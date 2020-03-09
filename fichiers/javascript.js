//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//charge le fichier XML se trouvant à l'URL relative donné dans le paramètreet le retourne
function chargerHttpXML(xmlDocumentUrl) {

    var httpAjax;

    httpAjax = window.XMLHttpRequest ?
        new XMLHttpRequest() :
        new ActiveXObject('Microsoft.XMLHTTP');

    if (httpAjax.overrideMimeType) {
        httpAjax.overrideMimeType('text/xml');
    }

    //chargement du fichier XML à l'aide de XMLHttpRequest synchrone (le 3° paramètre est défini à false)
    httpAjax.open('GET', xmlDocumentUrl, false);
    httpAjax.send();

    return httpAjax.responseXML;
}

function modiferCouleur(){
	document.body.style.backgroundColor = "cyan";
	
}
function remettreCouleur(){
	document.body.style.backgroundColor = "white";
}

function button3(xmlDocumentUrl, xslDocumentUrl){
	var code = document.getElementById("id_code_a_saisir").value;
	
	var xsltProcessor = new XSLTProcessor();

    // Chargement du fichier XSL à l'aide de XMLHttpRequest synchrone 
    var xslDocument = chargerHttpXML(xslDocumentUrl);

    // Importation du .xsl
    xsltProcessor.importStylesheet(xslDocument);

    // Chargement du fichier XML à l'aide de XMLHttpRequest synchrone 
    var xmlDocument = chargerHttpXML(xmlDocumentUrl);

	xsltProcessor.setParameter('','code',code);

    // Création du document XML transformé par le XSL
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);
	
	var capital = newXmlDocument.getElementById("capital").innerHTML;
	var name = newXmlDocument.getElementById("name").innerHTML;
	
	var capitalARemplir = document.getElementById("id_capital_a_remplacer");
	var nameARemplir = document.getElementById("id_nom_a_remplacer");
	
	//if no country found
	if(!capital){
		capitalARemplir.innerHTML="No country found";
		nameARemplir.innerHTML="No country found";
	}else{
    capitalARemplir.innerHTML = capital;
	nameARemplir.innerHTML=name;}
}

function chargerSVG(svgUrl,container,buttonNo){
	// Chargement du fichier XML à l'aide de XMLHttpRequest synchrone 
    var xmlDocument = chargerHttpXML(svgUrl);
	var svg=xmlDocument.getElementsByTagName("svg")[0];//getElements returns an array
	var imageContainer=document.getElementById(container);
	imageContainer.appendChild(svg);
	//rend le bouton uncliquable après ajouter le svg
	var bouton=document.getElementById(buttonNo);
	bouton.disabled=true;
}

function SVGclickHandler(event){
	console.log(event.target);
	var titleARemplacer=document.getElementById("id_title_a_remplacer");
	titleARemplacer.innerHTML=event.target.attributes[1].nodeValue;
}

function clickableSVG(index){
	var svg=document.getElementsByTagName("svg")[index];
	var svgChildren=svg.childNodes;
	for(var i=0;i<svgChildren.length;i++){
		svgChildren[i].addEventListener("click",SVGclickHandler);
	}
}

function mouseOverHandler(){
	var name = this.attributes[1].nodeValue;//nom commun du pays
	
	var xsltProcessor = new XSLTProcessor();

    // Chargement du fichier XSL à l'aide de XMLHttpRequest synchrone 
    var xslDocument = chargerHttpXML("cherchePaysParNom.xsl");

    // Importation du .xsl
    xsltProcessor.importStylesheet(xslDocument);

    // Chargement du fichier XML à l'aide de XMLHttpRequest synchrone 
    var xmlDocument = chargerHttpXML("countriesTP.xml");

	xsltProcessor.setParameter('','name',name);

    // Création du document XML transformé par le XSL
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);
	
	var capital = newXmlDocument.getElementById("capital").innerHTML;
	var cca2 = newXmlDocument.getElementById("cca2").innerHTML;
	
	
	console.log(name);
	console.log(capital);
	console.log(cca2);
	var td_nom=document.getElementById("td_nom");
	td_nom.innerHTML=name;
	var td_capital=document.getElementById("td_capital");
	td_capital.innerHTML=capital;
	var td_drapeau=document.getElementById("td_drapeau");
	var drapeauImg=document.createElement("img");
	drapeauImg.style.width="40px";
	drapeauImg.style.height="20px";
	drapeauImg.src="http://www.geonames.org/flags/x/"+cca2.toLowerCase() + ".gif";
	td_drapeau.appendChild(drapeauImg);
	this.style.fill="cyan";
}

function mouseLeaveHandler(){
	console.log(event.target);
	var td_nom=document.getElementById("td_nom");
	td_nom.innerHTML="";
	var td_capital=document.getElementById("td_capital");
	td_capital.innerHTML="";
	var td_drapeau=document.getElementById("td_drapeau");
	td_drapeau.innerHTML="";
	this.style.fill="#cccccc";
}

function mouseOver(){
	/*var svgs=document.getElementsByTagName("svg");
	var svg=svgs[svgs.length-1];
	console.log(svg)
	var svgChildren=svg.childNodes;
	for(var i=0;i<svgChildren.length;i++){
		svgChildren[i].addEventListener("mouseover",mouseOverHandler);
		svgChildren[i].addEventListener("mouseleave",mouseLeaveHandler);
	}*/
	var paths=document.getElementsByClassName("land");
	for(var i=0;i<paths.length;i++){
		paths[i].addEventListener("mouseover",mouseOverHandler);
		paths[i].addEventListener("mouseleave",mouseLeaveHandler);
	}
}

function fillOptions(){
	var xsltProcessor = new XSLTProcessor();
	 // Chargement du fichier XSL à l'aide de XMLHttpRequest synchrone 
    var xslDocument = chargerHttpXML("codePicker.xsl");

    // Importation du .xsl
    xsltProcessor.importStylesheet(xslDocument);

    // Chargement du fichier XML à l'aide de XMLHttpRequest synchrone 
    var xmlDocument = chargerHttpXML("countriesTP.xml");


    // Création du document XML transformé par le XSL
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);
	
	var options=newXmlDocument.getElementsByTagName("option");
	var datalist=document.getElementById("id_datalist");
	datalist.appendChild(options);
}

