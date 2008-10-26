    
    # TODO : get number of pages & total result as well
    def page(num)
      @page = reset && @request.params = num.to_s
    end