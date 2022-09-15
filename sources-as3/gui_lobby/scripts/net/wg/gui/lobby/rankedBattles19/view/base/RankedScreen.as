package net.wg.gui.lobby.rankedBattles19.view.base
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.utils.IViewRestrictions;
   import scaleform.clik.motion.Tween;
   
   public class RankedScreen extends AbstractView
   {
      
      protected static const FADE_IN_TIME:int = 500;
      
      private static const BG_LOADER_NAME:String = "BgLoader";
       
      
      protected var bgActualWidth:int = 0;
      
      protected var bgActualHeight:int = 0;
      
      protected var viewRestrictions:IViewRestrictions = null;
      
      protected var changeBgPlacement:Boolean = true;
      
      protected var fadeAnimat:Boolean = false;
      
      protected var bgLoader:Loader = null;
      
      private var _backgroundCenter:Boolean = false;
      
      private var _bgIsLoaded:Boolean = false;
      
      private var _showTween:Tween = null;
      
      public function RankedScreen()
      {
         super();
         this.bgLoader = new Loader();
         this.bgLoader.name = BG_LOADER_NAME;
         addChildAt(this.bgLoader,0);
         this.bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this.viewRestrictions = App.utils.viewRestrictions;
      }
      
      override public function playShowTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         if(this.fadeAnimat)
         {
            alpha = 0;
            this._showTween = new Tween(FADE_IN_TIME,param1,{"alpha":1},{
               "paused":false,
               "onComplete":param2
            });
            return true;
         }
         return false;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.recalculateBgSize(param1,param2);
         this.updateBG();
      }
      
      override protected function onDispose() : void
      {
         if(this.bgLoader != null)
         {
            if(this._bgIsLoaded)
            {
               this.bgLoader.unload();
            }
            this.bgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
            this.bgLoader = null;
         }
         this.viewRestrictions = null;
         if(this._showTween)
         {
            this._showTween.paused = true;
            this._showTween.dispose();
            this._showTween = null;
         }
         super.onDispose();
      }
      
      public function setBackground(param1:String, param2:Boolean = false) : void
      {
         this._bgIsLoaded = false;
         this._backgroundCenter = param2;
         var _loc3_:URLRequest = new URLRequest(param1);
         var _loc4_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this.bgLoader.scaleX = 1;
         this.bgLoader.scaleY = 1;
         this.bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this.bgLoader.load(_loc3_,_loc4_);
      }
      
      protected function updateBG() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._bgIsLoaded)
         {
            _loc1_ = this.bgLoader.width / this.bgLoader.scaleX;
            _loc2_ = this.bgLoader.height / this.bgLoader.scaleY;
            if(this.bgActualHeight < _loc2_ * this.bgActualWidth / _loc1_)
            {
               this.bgLoader.width = this.bgActualWidth;
               this.bgLoader.scaleY = this.bgLoader.scaleX;
            }
            else
            {
               this.bgLoader.height = this.bgActualHeight;
               this.bgLoader.scaleX = this.bgLoader.scaleY;
            }
            if(this._backgroundCenter)
            {
               this.bgLoader.x = this.bgActualWidth - this.bgLoader.width >> 1;
            }
            if(this.changeBgPlacement)
            {
               this.bgLoader.y = this.viewRestrictions.topOffset - y | 0;
            }
            else
            {
               this.bgLoader.y = -y | 0;
            }
         }
      }
      
      protected function recalculateBgSize(param1:int, param2:int) : void
      {
         this.bgActualWidth = param1;
         this.bgActualHeight = param2 - int(!!this.changeBgPlacement ? this.viewRestrictions.verticalOffset : 0);
      }
      
      private function onLoaderCompleteHandler(param1:Event) : void
      {
         this._bgIsLoaded = true;
         this.bgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderCompleteHandler);
         this.updateBG();
      }
   }
}
