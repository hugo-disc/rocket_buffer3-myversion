local users = {}
local logged = ''

local function exists(username)
    return table.find(users, function (value)
      return value.userLogin == username
    end)
  end

local function createAccount(_, email, login, senha, discord)
    if (type(email) ~= 'string' and type(login) ~= 'string' and type(senha) ~= 'string') then
        return print('[X] Parâmetros inválidos')
    end

    if (exists(login)) then
        return print('[X] Já há uma conta registrada com este login')
    end

    table.insert(users,
        {
            userLogin = login,
            password = senha,
            email = email,
            discord = discord, 
        }
    )

    return print('[V] Você se registrou com sucesso!')
end
addCommandHandler('bregister', createAccount)

local function loginIntoAccount(_, login, senha)

    if (type(email) ~= 'string' and type(login) ~= 'string' and type(senha) ~= 'string') then
        return print('[X] Parâmetros inválidos')
    end

    local exists = exists(login)

    if (logged) then
        return print('[X] Você já está logado em nosso sistema!')
    end

    if (not exists) then
        return print('[X] Conta inexistente')
    end
    
    local accountFind = users[exists] -- indexando a conta encontrada na variável accountFind para que fique melhor 

    if(accountFind.password ~= senha) then -- verificando se a conta com o login informado, possui a senha informada
        return print('[X] A senha inserida não é a mesma da conta inserida') -- caso não tenha, irá printar isto no console
    end
    
    logged = accountFind.userLogin -- indexando o login da conta ao player, e "logando" ele no sistema
    print('\n[W] Seja bem-vindo(a) ' .. accountFind.userLogin .. '!\n・O seu discord é: ' .. accountFind.discord .. '\n・O seu email é: ' .. accountFind.email)

    accountFind = nil -- limpando a variável, pois não utilizei ela novamente
    exists = nil -- limpando a variável, pois não utilizei ela novamente
    return
end
addCommandHandler('blogin', loginIntoAccount)

local function deleteAccount(login)
    if (type(login) ~= 'string') then
        return print('[X] O login inserido é inválido!')
    end

    if(not exists(login)) then
        return print('[X] Não encontrei nenhuma conta com este login!')
    end

    users[exists(login)] = nil
    logged = nil

    return
end

local function logoutAccount()
    if (not logged) then
        return
    end

    deleteAccount(logged)
    print('[V] Você se deslogou do sistema com sucesso!')
    
    logged = false
    return
end
addCommandHandler('blogout', logoutAccount)

local function getUsers()
    return print('[U] Atualmente possuimos ' ..#users.. ' usuários registrados!')
end
addCommandHandler('busers', getUsers)
