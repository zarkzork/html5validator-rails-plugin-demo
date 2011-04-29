module Html5Forms
  module FormFor
    def form_for(record_or_name_or_array, *args, &proc)
      puts args
      if args.last.kind_of? Hash
        unless args.has_key?[:builder]
          args.last[:builder] = Html5Forms::FormBuilder
        end
      else
        args << { :builder => Html5Forms::FormBuilder }
      end
      super(record_or_name_or_array, *args, &proc)
    end
  end
end
