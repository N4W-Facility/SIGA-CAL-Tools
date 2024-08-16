!dir &
disp('hola mundo')
return

try
    o = [1 1]* [1 1 1 1 1 1 1 1];
    
catch ME
    errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
        ME.stack(1).name, ME.stack(1).line, ME.message);
    errordlg( errorMessage )
    return
end