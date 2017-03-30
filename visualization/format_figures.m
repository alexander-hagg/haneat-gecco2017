ax = gca;
ax.Units = 'Centimeters';
grid on;
ax.XLabel.FontSize = fontsize_label;
ax.YLabel.FontSize = fontsize_label;
ax.FontSize = fontsize_tick;

%% Change Histogram figures
ymaxsplit = 100;

%% Change RMSE figures
%     ax.YLim = [8*10^-2 10^0];
%     ax.YScale = 'log';
%     legend off;hold off;
%     legendflex({'Tanh','Sigmoid','Gauss','Step','Dolinsky','Sine','HeteroNEAT'},'xscale',4)
%     for i=1:length(ax.Children)
%         ax.Children(i).LineWidth = 6;
%         ax.Children(i).LineStyle = linestyles{mod(i,3)+1};
%         ax.Children(i).Color = linecolors{mod(i,2)+1};
%     end
%     ax.Children(1).LineWidth = 10;
%     % uistack(ax.Children(end),'top');
%     ax.YLabel.String = 'RMSE';

%% Change DP steps figures
%     for i=1:length(ax.Children)
%         ax.Children(i).LineWidth = 6;
%         ax.Children(i).LineStyle = linestyles{mod(i,3)+1};
%         ax.Children(i).Color = linecolors{mod(i,2)+1};
%     end
%     ax.YLim = [50 20000];
%     % uistack(ax.Children(end),'top');
%     ax.Title.String = [];
%     ax.YLabel.String = 'Steps';
%     ax.YTickLabel = {'50','500','5000', '50000'};
%     legend off;hold off;
%     legendflex({'Sine','Dolinsky','Step','Gauss','Sigmoid','Tanh','HeteroNEAT'},'xscale',4,'anchor', [5 5])

%%
%savefig(fig,[filename '.fig']);
%save2pdf([filename '.pdf'],fig,600,[12 12]);
%system(['pdfcrop ' [filename '.pdf'] ' ' [filename '.pdf']]);


