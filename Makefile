deploy-testnet:
	op run --env-file="./.env" -- \
	forge script DeployKatanaOperationTestnet -f ronin-testnet

deploy-testnet-broadcast:
	op run --env-file="./.env" -- \
	forge script DeployKatanaOperationTestnet -f ronin-testnet --verify --verifier sourcify --verifier-url https://sourcify.roninchain.com/server/ --legacy --broadcast

deploy-mainnet:
	forge script DeployKatanaOperationMainnet -f ronin-mainnet -t

deploy-mainnet-broadcast:
	forge script DeployKatanaOperationMainnet -f ronin-mainnet --verify --verifier sourcify --verifier-url https://sourcify.roninchain.com/server/ --legacy --broadcast -t
