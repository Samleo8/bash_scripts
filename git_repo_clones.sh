FONT_COLLECTION=1

HYMN_COMPOSITIONS=1

ELECTRONICS=1

CV_REPOS=1
CV_DARKNET=1
CV_YOLO_PY=1
CV_FACIAL_RECOGNITION=1

TELEGRAM_BOTS=1
MOBILE_APPS=1

GITHUB_WEBSITE=1

if [ $FONT_COLLECTION -eq 1 ]; then
	echo "Cloning font collection into ~/Fonts"
	cd ~
	git clone git@github.com:Samleo8/font-collection.git Fonts
fi

if [ $HYMN_COMPOSITIONS -eq 1 ]; then
	echo "Cloning Lilypond Hymn compositions into ~/Music"
	cd ~/Music
	git clone git@github.com:Samleo8/HymnCompositions.git
fi

if [ $ELECTRONICS -eq 1 ]; then
	echo "Cloning MSP430 Codes into ~/Electronics"
	cd ~
	mkdir -p Electronics
	cd ~/Electronics
	git clone git@github.com:Samleo8/MSP430Codes.git
fi

if [ $CV_REPOS -eq 1 ]; then
	echo "Setting up CV Playground..."

	cd ~
	mkdir -p CVPlayground
	cd ~/CVPlayground
	
	if [ $CV_DARKNET -eq 1 ]; then
		echo "Cloning darknet into ~/CVPlayground"
		git clone git@github.com:Samleo8/darknet.git
	fi
	
	if [ $CV_FACIAL_RECOGNITION -eq 1 ]; then
		echo "Cloning facial recognition test into ~/CVPlayground"
		git clone git@github.com:Samleo8/FacialRecognitionOpenCV.git FacialRecognition
	fi
	
	if [ $CV_YOLO_PY -eq 1 ]; then
		echo "Cloning yolo python test into ~/CVPlayground"	
		git clone git@github.com:Samleo8/YOLOPythonTest.git yolo_python
	fi
fi


if [ $TELEGRAM_BOTS -eq 1 ]; then
	echo "Cloning telegram bot codes into ~/Documents/Telegram\ Bots"
	cd ~/Documents
	mkdir -p "Telegram Bots"
	cd "Telegram Bots"
	
	git clone git@github.com:Samleo8/BibleQuizzle.git
	git clone git@github.com:Samleo8/BRMCGamesLeaderboard.git
fi

if [ $MOBILE_APPS -eq 1 ]; then	
	echo "Cloning mobile app codes into ~/Documents/Mobile\ Apps"
	cd ~/Documents
	mkdir -p "Mobile Apps"
	cd "Mobile Apps"

	git clone git@github.com:Samleo8/SoaringSheep.git
	git clone git@github.com:Samleo8/SisyphusSheep.git
fi


if [ $GITHUB_WEBSITE -eq 1 ]; then
	echo "Cloning mobile app codes into ~/Documents/Github\ Website"
	cd ~/Documents
	git clone git@github.com:Samleo8/samleo8.github.io.git "Github Website"
fi

