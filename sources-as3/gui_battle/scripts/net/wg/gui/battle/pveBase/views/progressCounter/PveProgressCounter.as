package net.wg.gui.battle.pveBase.views.progressCounter
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.base.meta.IPveProgressCounterMeta;
   import net.wg.infrastructure.base.meta.impl.PveProgressCounterMeta;
   
   public class PveProgressCounter extends PveProgressCounterMeta implements IPveProgressCounterMeta
   {
      
      private static const START_ANIM_FRAME_LABEL:String = "startAnim";
      
      private static const LAST_HIDE_FRAME_LABEL:String = "lastHideFrame";
      
      private static const SHOW_SHADOW_LABEL:String = "show";
      
      private static const HIDE_SHADOW_LABEL:String = "hide";
       
      
      public var titleAnim:TitleAnimation = null;
      
      public var shadow:MovieClip = null;
      
      private var _icon:String = "";
      
      private var _title:String = "";
      
      private var _titlePrev:String = "";
      
      private var _isAnimated:Boolean = true;
      
      private var _isStarted:Boolean = false;
      
      private var _lastHideFrame:int = 0;
      
      public function PveProgressCounter()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:FrameLabel = null;
         super.configUI();
         var _loc2_:int = currentLabels.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = currentLabels[_loc3_];
            if(_loc1_.name == LAST_HIDE_FRAME_LABEL)
            {
               this._lastHideFrame = _loc1_.frame - 1;
               break;
            }
            _loc3_++;
         }
         addFrameScript(this._lastHideFrame,this.onHidePlayComplete);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isStarted && isInvalid(InvalidationType.DATA))
         {
            if(this._isAnimated)
            {
               if(this._titlePrev.length != 0 && this._title.length == 0)
               {
                  this.shadow.gotoAndPlay(HIDE_SHADOW_LABEL);
               }
               gotoAndPlay(START_ANIM_FRAME_LABEL);
            }
            else
            {
               this.onHidePlayComplete();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.titleAnim.dispose();
         this.titleAnim = null;
         this.shadow = null;
         addFrameScript(this._lastHideFrame,null);
         super.onDispose();
      }
      
      public function onHidePlayComplete() : void
      {
         this.titleAnim.setIcon(this._icon);
         this.titleAnim.setText(this._title);
         this.titleAnim.setVisibleIcon(this._icon.length != 0 && this._title.length != 0);
         if(this._title.length != 0 && this._titlePrev.length == 0)
         {
            this.shadow.gotoAndPlay(SHOW_SHADOW_LABEL);
         }
         this._titlePrev = this._title;
      }
      
      public function as_setData(param1:String, param2:String, param3:Boolean) : void
      {
         if(param2 == this._title)
         {
            return;
         }
         this._icon = param1;
         this._title = param2;
         this._isAnimated = param3;
         this._isStarted = true;
         invalidateData();
      }
   }
}
