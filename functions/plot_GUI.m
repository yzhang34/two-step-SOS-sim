function plot_GUI( handles )
%PLOT_GUI Summary of this function goes here
%   Detailed explanation goes here
%
%   Author: Yide Zhang
%   Email: yzhang34@nd.edu
%   Date: April 16, 2019
%   Copyright: University of Notre Dame, 2019

    %% plotting options
    line_width = 2;
    font_size = 10;
    marker_size = 8;
    % Set colormap for the plotting
    num_cc = 10;
    cc = lines(num_cc);
    cc(3,:)=[]; % not use yellow
    % 1 - blue
    % 2 - orange
    % 3 - purple
    % 4 - green
    % 5 - cyan
    % 6 - red

    %% GUI parameter reading   
   
    
    % 1PE2PE
    str_1PE2PE = get(handles.Popup_1PE2PE, 'String');
    val_1PE2PE = get(handles.Popup_1PE2PE, 'Value');
    switch str_1PE2PE{val_1PE2PE};
    case 'One-photon excitation'
        set(handles.Edit_lambda, 'String', num2str(488));
        N = 1;
        g_p = 1;
        sigma = 1.35e-20; % unit: m^2
        I_array_max = 1e12;
    case 'Two-photon excitation'
        set(handles.Edit_lambda, 'String', num2str(800));
        N = 2;
        g_p = 38690;
        sigma = 2e-56; % unit: m^4*s
        I_array_max = 1e12;
    end
    

    % lambda
    lambda = str2double(get(handles.Edit_lambda, 'String'));
    lambda = lambda * 1e-9;
    
    % NA
    NA = str2double(get(handles.Edit_NA, 'String'));    
    
    % lifetime
    tau = str2double(get(handles.Edit_lifetime, 'String'));  
    tau = tau * 1e-9;
    
    % tob
    tob = str2double(get(handles.Edit_tob, 'String'));  
    tob = tob * 1e-6;
    
    % psi_F
    psi_F = str2double(get(handles.Edit_psi_F, 'String'));  
    
    % N0
    N0 = str2double(get(handles.Edit_N0, 'String'));  
    
    % loglog scale or not
    do_loglog = get(handles.Check_Loglog, 'Value');
    
    % log_k scale or not
    do_log_k = get(handles.Check_Log_k, 'Value');
    
   
    % I01
    set(handles.Edit_I01_Max, 'String', num2str(I_array_max,'%.1e'));
    set(handles.Slider_I01, 'Min', 0.1)
    set(handles.Slider_I01, 'Max', I_array_max)
    I01 = str2double(get(handles.Edit_I01, 'String'));
    
    % I02
    set(handles.Edit_I02_Max, 'String', num2str(I_array_max,'%.1e'));
    set(handles.Slider_I02, 'Min', 0.11)
    set(handles.Slider_I02, 'Max', I_array_max)
    
    I02 = str2double(get(handles.Edit_I02, 'String'));
    



    %% other paramters calculation
    
    % Gaussian excitation beam
    w0 = lambda/(pi*NA);
    
    % spatial variables
    N_pixel = 4096;
    d_x = 1e-9; % each pixel is 5 nm
    x = linspace(-d_x*(N_pixel/2-1), d_x*N_pixel/2, N_pixel);
    
    % Gaussian shape function
    g_x = exp(-2*(x.^2)/(w0^2));
    
    % 2-step excitation
    I1_x = I01 * g_x;
    I2_x = I02 * g_x;
    
    % compact parametrize
    h = 6.626e-34;
    c = 3e8;
    gamma = lambda/(h*c);
    a = tau * g_p * sigma * gamma^N;
    eta = 0.3;
    tau_r = tau/eta;
    K = psi_F*tob/tau_r;
    
    
    % exc-fluo relationship
    N_exc = 1000;
    I_array = logspace(0, log10(I_array_max), N_exc);
    F_array = K * N0 * (a*I_array.^N) ./ (1 + a*I_array.^N);
    
    
    % 2-step fluorescence
    F1_x = K * N0 * (a*I1_x.^N) ./ (1 + a*I1_x.^N);
    F2_x = K * N0 * (a*I2_x.^N) ./ (1 + a*I2_x.^N);
        
    % 2-step DC SOS
    FSOS2_x = F1_x * I02^N / (I01^N) - F2_x;
    
    % normalization
    F1_x_norm = F1_x/max(F1_x);
    F2_x_norm = F2_x/max(F2_x);
    FSOS2_x_norm = FSOS2_x/max(FSOS2_x);
    
    % calculate FWHM
    F1_x_FWHM = fwhm(x,F1_x_norm)*1e9;
    F2_x_FWHM = fwhm(x,F2_x_norm)*1e9;
    FSOS2_x_FWHM = fwhm(x,FSOS2_x_norm)*1e9;
    
    set(handles.Edit_1_FWHM, 'String', num2str(F1_x_FWHM,'%.2f'));
    set(handles.Edit_2_FWHM, 'String', num2str(F2_x_FWHM,'%.2f'));
    set(handles.Edit_SOS2_FWHM, 'String', num2str(FSOS2_x_FWHM,'%.2f'));
    
    min_x = -600e-9;
    max_x = 600e-9;
    
    
    %% Fourier Transform
    % frequency domain variables
    N_k = 2^nextpow2(N_pixel);
    d_k = 1/(d_x*N_k);
    k = linspace(-d_k*(N_k/2-1), d_k*N_k/2, N_k);
    
    % 2-step fluorescence
    F1_k = abs(fftshift(fft(F1_x, N_k)/N_k));
    F2_k = abs(fftshift(fft(F2_x, N_k)/N_k));
        
    % 2-step DC SOS
    FSOS2_k = abs(fftshift(fft(FSOS2_x, N_k)/N_k));
    
    % normalization
    F1_k_norm = F1_k/max(F1_k);
    F2_k_norm = F2_k/max(F2_k);
    FSOS2_k_norm = FSOS2_k/max(FSOS2_k);
    
    min_k = -1e7;
    max_k = 1e7;
    
    
    %% plotting
    
    % plot Axes_Exc_Fluo
    if do_loglog
        h = loglog(handles.Axes_Exc_Fluo, I_array, F_array, '-');
    else
        h = plot(handles.Axes_Exc_Fluo, I_array, F_array, '-');
    end
    ylabel(handles.Axes_Exc_Fluo, 'Fluorescence (a.u.)')
    xlabel(handles.Axes_Exc_Fluo, 'Excitation irradiance (W/m^2)')
    xlim(handles.Axes_Exc_Fluo, [min(I_array) max(I_array)])
    set(handles.Axes_Exc_Fluo, 'FontSize',font_size);
    set(h,'linewidth',line_width);
    set(h,'markersize',marker_size);
    
    
    % plot I01I02_x
    h = plot(handles.Axes_I01I02_x, x, F1_x, '.', x, F2_x, '.');
    ylabel(handles.Axes_I01I02_x, 'Fluorescence (a.u.)')
    xlim(handles.Axes_I01I02_x, [min_x max_x])
    set(handles.Axes_I01I02_x, 'FontSize',font_size);
    set(h,'linewidth',line_width);
    set(h,'markersize',marker_size);    
    legend(handles.Axes_I01I02_x, 'Step 1', 'Step 2')
    
   	% plot SOS2_x
    h = plot(handles.Axes_SOS2_x, x, FSOS2_x, '-');
    ylabel(handles.Axes_SOS2_x, 'Fluorescence (a.u.)')
    xlim(handles.Axes_SOS2_x, [min_x max_x])
    set(handles.Axes_SOS2_x, 'FontSize',font_size);
    set(h,'linewidth',line_width);
    set(h,'markersize',marker_size);    
    legend(handles.Axes_SOS2_x, 'SOS2')
    set(h,'color',cc(3,:));

    % plot norm_x
    h = plot(handles.Axes_norm_x, x, F1_x_norm, '.', x, F2_x_norm, '.', x, FSOS2_x_norm, '-');
    ylabel(handles.Axes_norm_x, 'Normalized fluorescence (a.u.)')
    xlabel(handles.Axes_norm_x, 'x (m)')
    xlim(handles.Axes_norm_x, [min_x max_x])
    % ylim(handles.Axes_norm_x, [-0.2 1.2])
    set(handles.Axes_norm_x, 'FontSize',font_size);
    set(h,'linewidth',line_width);
    set(h,'markersize',marker_size);    
    legend(handles.Axes_norm_x, 'Step 1 (norm)', 'Step 2 (norm)', 'SOS2 (norm)')
    for ih=1:length(h)
        set(h(ih),'color',cc(ih,:));
    end
    
    
    % plot I01I02_k
    if do_log_k
        h = semilogy(handles.Axes_I01I02_k, k, F1_k, '.-', k, F2_k, '.-');
    else
        h = plot(handles.Axes_I01I02_k, k, F1_k, '.-', k, F2_k, '.-');
    end
    xlim(handles.Axes_I01I02_k, [min_k max_k])
    set(handles.Axes_I01I02_k, 'FontSize',font_size);
    set(h,'linewidth',line_width);
    set(h,'markersize',marker_size);    
    legend(handles.Axes_I01I02_k, 'Step 1', 'Step 2')
    
   	% plot SOS2_k    
    if do_log_k
        h = semilogy(handles.Axes_SOS2_k, k, FSOS2_k, '-');
    else
        h = plot(handles.Axes_SOS2_k, k, FSOS2_k, '-');
    end
    xlim(handles.Axes_SOS2_k, [min_k max_k])
    set(handles.Axes_SOS2_k, 'FontSize',font_size);
    set(h,'linewidth',line_width);
    set(h,'markersize',marker_size);    
    legend(handles.Axes_SOS2_k, 'SOS2')
    set(h,'color',cc(3,:));

    % plot norm_k
    if do_log_k
        h = semilogy(handles.Axes_norm_k, k, F1_k_norm, '.-', k, F2_k_norm, '.-', k, FSOS2_k_norm, '-');
    else
        h = plot(handles.Axes_norm_k, k, F1_k_norm, '.-', k, F2_k_norm, '.-', k, FSOS2_k_norm, '-');
    end
    xlabel(handles.Axes_norm_k, 'k (m^{-1})')
    xlim(handles.Axes_norm_k, [min_k max_k])
    % ylim(handles.Axes_norm_k, [-0.2 1.2])
    set(handles.Axes_norm_k, 'FontSize',font_size);
    set(h,'linewidth',line_width);
    set(h,'markersize',marker_size);    
    legend(handles.Axes_norm_k, 'Step 1 (norm)', 'Step 2 (norm)', 'SOS2 (norm)')
    for ih=1:length(h)
        set(h(ih),'color',cc(ih,:));
    end


end

