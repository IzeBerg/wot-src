package net.wg.gui.battle.components.poi.components
{
   import flash.display.MovieClip;
   import mx.effects.easing.Cubic;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class PoiProgressCircleWrapper extends BattleUIComponent
   {
      
      private static const SHOW_HIDE_TWEEN_DURATION:int = 400;
      
      private static const WIDTH:int = 60;
      
      private static const HEIGHT:int = 60;
       
      
      private var _progress:PoiProgressCircle;
      
      private var _tween:Tween = null;
      
      private var _iconType:uint = 0;
      
      private var _progressLinkage:String = "PlayersPanelPoiProgressBarUI";
      
      public function PoiProgressCircleWrapper(param1:String = "", param2:int = 60, param3:int = 60)
      {
         if(StringUtils.isNotEmpty(param1))
         {
            this._progressLinkage = param1;
         }
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._progress = App.instance.utils.classFactory.getComponent(this.progressLinkage,PoiProgressCircle);
         addChild(this._progress);
         this._progress.setOwner(true);
      }
      
      override protected function onDispose() : void
      {
         this.clearContentTween();
         this._progress.dispose();
         this._progress = null;
         super.onDispose();
      }
      
      public function clearContentTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      public function hide(param1:Function) : void
      {
         this.switchContentVisibility(false,param1);
      }
      
      public function isTweenInProgress() : Boolean
      {
         if(this._tween && !this._tween.paused)
         {
            return true;
         }
         return false;
      }
      
      public function setOwner(param1:Boolean) : void
      {
         this._progress.setOwner(param1);
      }
      
      public function show(param1:Function, param2:Boolean = true) : void
      {
         this.switchContentVisibility(true,param1,param2);
      }
      
      public function updateProgress(param1:Number) : void
      {
         this._progress.updateProgress(param1);
      }
      
      private function switchContentVisibility(param1:Boolean, param2:Function, param3:Boolean = true) : void
      {
         var isShow:Boolean = param1;
         var onContentAnimCompleted:Function = param2;
         var useAnim:Boolean = param3;
         this.clearContentTween();
         var toAlpha:Number = !!isShow ? Number(Values.DEFAULT_ALPHA) : Number(Values.ZERO);
         var easing:Function = !!isShow ? Cubic.easeIn : Cubic.easeOut;
         if(useAnim && alpha != toAlpha)
         {
            this._tween = new Tween(SHOW_HIDE_TWEEN_DURATION,this,{"alpha":toAlpha},{
               "ease":easing,
               "onComplete":function():void
               {
                  onContentAnimCompleted(_iconType);
               }
            });
         }
         else
         {
            alpha = toAlpha;
            onContentAnimCompleted(this._iconType);
         }
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      public function get iconType() : uint
      {
         return this._iconType;
      }
      
      public function set iconType(param1:uint) : void
      {
         this._iconType = param1;
         this._progress.iconType = param1;
      }
      
      public function get icon() : MovieClip
      {
         return this._progress.icon;
      }
      
      public function get highlight() : MovieClip
      {
         return this._progress.highlight;
      }
      
      public function get progressLinkage() : String
      {
         return this._progressLinkage;
      }
      
      public function set progressLinkage(param1:String) : void
      {
         this._progressLinkage = param1;
      }
      
      public function get progressCircle() : MovieClip
      {
         return this._progress.progressCircle;
      }
   }
}
