# pdf.cr 
> PDF for Crystal
forked from [marceloboeira's repository](https://github.com/marceloboeira/pdf.cr)

this lib provides generation and (todo) analysis of pdf documents

Some of the document is written in Chinese, and they will later be replaced with texts from the standard

We'll first support PDF-1.3, which can be seen in the `references` directory
## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  pdf:
    github: homodeluna/pdf.cr
```

## Contributing

We're now mapping types definition from scecification to crystal, part of our result can be seen in the `/src/document` directory.
If you want to contribute, please help us to map all the types needed to crystal, adding comments from the reference is also welcomed.

1. Fork it (https://github.com/homodeluna/pdf.cr/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
