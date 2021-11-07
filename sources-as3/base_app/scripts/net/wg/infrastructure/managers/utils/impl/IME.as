package net.wg.infrastructure.managers.utils.impl
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   import net.wg.utils.IIME;
   import scaleform.gfx.IMECandidateListStyle;
   import scaleform.gfx.IMEEx;
   
   public class IME implements IIME
   {
       
      
      private var _container:ISimpleManagedContainer = null;
      
      private var langBar:MovieClip = null;
      
      private var statusWinContainer:MovieClip = null;
      
      private var _langBarLoader:Loader = null;
      
      private var _statusWindowLoader:Loader = null;
      
      private const BGColor:Number = 4145200;
      
      private const BGColorOnOver:Number = 6448204;
      
      private const TextColor:Number = 16774371;
      
      private const TextColorSelected:Number = 16777215;
      
      public function IME(param1:ISimpleManagedContainer)
      {
         super();
         this._container = param1;
         this._container.visible = false;
      }
      
      public function dispose() : void
      {
         if(this._container)
         {
            if(this.langBar)
            {
               this.removeLangBarHandlers();
               this._container.removeChild(this.langBar);
               this.langBar = null;
            }
            if(this.statusWinContainer)
            {
               this.removeStatusContainerHandler();
               this._container.removeChild(this.statusWinContainer);
               this.statusWinContainer = null;
            }
            this._container = null;
         }
         if(this._langBarLoader != null)
         {
            this._langBarLoader.unloadAndStop();
            this._langBarLoader = null;
         }
         if(this._statusWindowLoader != null)
         {
            this._statusWindowLoader.unloadAndStop();
            this._statusWindowLoader = null;
         }
      }
      
      public function getContainer() : ISimpleManagedContainer
      {
         return this._container;
      }
      
      public function init(param1:Boolean) : void
      {
         var _loc2_:LoaderContext = null;
         var _loc3_:URLRequest = null;
         var _loc4_:URLRequest = null;
         if(this._container && param1)
         {
            _loc2_ = new LoaderContext(false,ApplicationDomain.currentDomain,null);
            _loc3_ = new URLRequest("LangBar.swf");
            this._langBarLoader = new Loader();
            this._langBarLoader.load(_loc3_,_loc2_);
            this._langBarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.langBarLoaded);
            this._langBarLoader.name = "LangBar";
            this._container.addChild(this._langBarLoader);
            _loc4_ = new URLRequest("StatusWindow.swf");
            this._statusWindowLoader = new Loader();
            this._statusWindowLoader.name = "StatusWindow";
            this._statusWindowLoader.load(_loc4_,_loc2_);
            this._statusWindowLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.statusWindowLoaded);
            this._container.addChild(this._statusWindowLoader);
         }
         this.initStyle();
      }
      
      public function onLangBarResize(param1:Number, param2:Number) : void
      {
         if(this.statusWinContainer != null)
         {
            this.statusWinContainer.x = param1;
            this.statusWinContainer.y = param2;
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(App.globalVarsMgr.isShowLangaugeBarS())
         {
            this._container.visible = param1;
         }
      }
      
      private function initStyle() : void
      {
         var _loc1_:IMECandidateListStyle = new IMECandidateListStyle();
         _loc1_.textColor = 0;
         _loc1_.selectedTextColor = 16777215;
         _loc1_.fontSize = 20;
         _loc1_.backgroundColor = 15725300;
         _loc1_.selectedBackgroundColor = 9755539;
         _loc1_.indexBackgroundColor = 12503505;
         _loc1_.selectedIndexBackgroundColor = 6994017;
         _loc1_.readingWindowTextColor = 0;
         _loc1_.readingWindowBackgroundColor = 15725300;
         _loc1_.readingWindowFontSize = 30;
         IMEEx.setIMECandidateListStyle(_loc1_);
      }
      
      private function udpateLangBar() : void
      {
         this.langBar.setOwner(this);
         this.updateStyle();
      }
      
      private function updateStyle() : void
      {
         if(this.langBar != null && this.statusWinContainer != null)
         {
            this.langBar.SetBackgroundColor(14608366,5619932);
            this.langBar.SetTextColor(5592921,16777215);
            this.statusWinContainer.SetBackgroundColor(14608366,5619932);
            this.statusWinContainer.SetTextColor(5592921,16777215);
            this.langBar.x = 0;
            this.langBar.y = 0;
            this.statusWinContainer.x = this.langBar.x + this.langBar.width;
            this.statusWinContainer.y = 0;
            this.langBar.SetTextColor(this.TextColor,this.TextColorSelected);
            this.langBar.SetBackgroundColor(this.BGColor,this.BGColorOnOver);
            this.statusWinContainer.SetTextColor(this.TextColor,this.TextColorSelected);
            this.statusWinContainer.SetBackgroundColor(this.BGColor,this.BGColorOnOver);
         }
      }
      
      private function removeLangBarHandlers() : void
      {
         this.langBar.removeEventListener("langBarReady",this.onLangBarReady);
         this.langBar.removeEventListener(Event.ENTER_FRAME,this.onLangBarEnterFrameHandler);
      }
      
      private function removeStatusContainerHandler() : void
      {
         this.statusWinContainer.removeEventListener("statusWindowReady",this.onStatusContainerReady);
         this.statusWinContainer.removeEventListener(Event.ENTER_FRAME,this.onStatusContainerEnterFrameHandler);
      }
      
      private function langBarLoaded(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.langBarLoaded);
         this.langBar = param1.currentTarget.content;
         this.langBar.addEventListener("langBarReady",this.onLangBarReady);
      }
      
      private function onLangBarReady(param1:Event) : void
      {
         this.langBar.removeEventListener("langBarReady",this.onLangBarReady);
         this.langBar.addEventListener(Event.ENTER_FRAME,this.onLangBarEnterFrameHandler);
      }
      
      private function statusWindowLoaded(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         _loc2_.removeEventListener(Event.COMPLETE,this.statusWindowLoaded);
         this.statusWinContainer = param1.currentTarget.content;
         this.statusWinContainer.addEventListener("statusWindowReady",this.onStatusContainerReady);
      }
      
      private function onStatusContainerReady(param1:Event) : void
      {
         this.statusWinContainer.removeEventListener("statusWindowReady",this.onStatusContainerReady);
         this.statusWinContainer.addEventListener(Event.ENTER_FRAME,this.onStatusContainerEnterFrameHandler);
      }
      
      private function onLangBarEnterFrameHandler(param1:Event) : void
      {
         this.udpateLangBar();
         this.removeLangBarHandlers();
      }
      
      private function onStatusContainerEnterFrameHandler(param1:Event) : void
      {
         this.updateStyle();
         this.removeStatusContainerHandler();
      }
   }
}
