fid = fopen('elements.json','w');

e = parseElements();

for indE = 1:length(e)
    e(indE).fparams.a = sprintf('%e,%e,%e',...
        e(indE).fparams.a(1),e(indE).fparams.a(2),e(indE).fparams.a(3));
    e(indE).fparams.b = sprintf('%e,%e,%e',...
        e(indE).fparams.b(1),e(indE).fparams.b(2),e(indE).fparams.b(3));
    e(indE).fparams.c = sprintf('%e,%e,%e',...
        e(indE).fparams.c(1),e(indE).fparams.c(2),e(indE).fparams.c(3));
    e(indE).fparams.d = sprintf('%e,%e,%e',...
        e(indE).fparams.d(1),e(indE).fparams.d(2),e(indE).fparams.d(3));
end

fprintf(fid, jsonencode( e ) );
fclose(fid);
