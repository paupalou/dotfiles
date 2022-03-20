function setpath
    for arg in $argv
        if not contains $arg $PATH
            set PATH $PATH $arg
        end
    end
end
