require 'test_helper'

class ProductsControllerTest< ActionDispatch::IntegrationTest
  test 'render a list of products' do
    get products_path

    assert_response :success
    assert_select '.product', 2
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4))

    assert_response :success
    assert_select '.title', 'PS4 Fat'
    assert_select '.description', 'Ps4 en buen estado'
    assert_select '.price', '150'
  end

  test 'render a new product form' do
    get new_product_path

    assert_response :success
    assert_select 'form'
  end

  test ' allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'Nintendo 64',
        description: 'Le faltan los cables',
        price: 45
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Producto creado correctamente'
  end

  test ' does not allow to create a new product' do
    post products_path, params: {
      product: {
        title: '',
        description: 'Le faltan los cables',
        price: 45
      }
    }
    assert_response :unprocessable_entity
  end
end
