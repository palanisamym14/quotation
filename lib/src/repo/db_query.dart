 final String selectQuotation = '''select items.*, 
  product.description, 
  product.id 
  from product inner join  items on items.productId = product.id 
  inner join quotation on quotation.id = items.quotationId 
  where quotation.isDeleted !=1 order by sequenceNo desc''';
  final String selectQuotationHistory = '''select customer.name as customerName, 
  customer.addressLine1, 
  customer.addressLine2, 
  customer.mobile, 
  customer.email, 
  quotation.*, 
  quotationSummary.id as summeryId, 
  quotationSummary.netPay, 
  quotationSummary.grandTotal, 
  quotationSummary.wages, 
  quotationSummary.discount 
  from customer inner join  quotation on quotation.customerId = customer.id 
  inner join quotationSummary on quotationSummary.quotationId = quotation.id 
  where quotation.isDeleted !=1  order by createdDate desc''';

  final String selectQuotationById = '''select quotation.*, 
  product.description, product.id  
  from product inner join  quotation on quotation."productId" = product.id 
  inner join quotationHdr on "quotationHdr".id = quotation."quotationHdrId" 
  where quotation."quotationHdrId" = \':val\'  and "quotationHdr"."isDeleted" !=1 order by "sequenceNo" desc''';
