package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import fl.motion.easing.Cubic;
   import flash.geom.Point;
   import net.wg.gui.lobby.personalMissions.data.FreeSheetObtainedPopupVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class FreeSheetObtainedPopup extends AbstractFreeSheetPopup
   {
      
      private static const WIDTH:int = 941;
      
      private static const HEIGHT:int = 366;
      
      private static const HIDE_FRAME_IND:int = 129;
      
      private static const TWEEN_DURATION:int = 1000;
      
      private static const ICON_OFFSET_Y:int = 40;
      
      private static const ICON_OFFSET_X:int = 60;
      
      private static const ICON_SCALE:Number = 0.4;
       
      
      public var title:FreeSheetTitle;
      
      public var textBlocks:AwardSheetTextBlocks;
      
      public var logo:AwardSheetAnimation;
      
      private var _vo:FreeSheetObtainedPopupVO;
      
      private var _tween:Tween;
      
      public function FreeSheetObtainedPopup()
      {
         super();
      }
      
      override public function init(param1:Boolean, param2:Object) : void
      {
         super.init(param1,param2);
         if(param2 != null)
         {
            this._vo = new FreeSheetObtainedPopupVO(param2);
            invalidateData();
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vo && isInvalid(InvalidationType.DATA))
         {
            this.logo.setIcon(this._vo.icon);
            this.title.setTitle(this._vo.title);
            this.textBlocks.setData(this._vo.titleLeft,this._vo.descrLeft,this._vo.titleRight,this._vo.descrRight);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
         this.title.dispose();
         this.title = null;
         this.textBlocks.dispose();
         this.textBlocks = null;
         this.logo.dispose();
         this.logo = null;
         this._vo.dispose();
         this._vo = null;
         super.onDispose();
      }
      
      public function setAwardSheetDestPosition(param1:Point) : void
      {
         var _loc2_:Point = globalToLocal(param1);
         this._tween = new Tween(TWEEN_DURATION,this.logo,{
            "x":_loc2_.x + ICON_OFFSET_X,
            "y":_loc2_.y + ICON_OFFSET_Y,
            "scaleX":ICON_SCALE,
            "scaleY":ICON_SCALE
         },{
            "paused":false,
            "ease":Cubic.easeIn,
            "onComplete":this.onTweenComplete
         });
      }
      
      private function onTweenComplete() : void
      {
         this.logo.playAnimation();
      }
      
      override protected function get hideFrameInd() : int
      {
         return HIDE_FRAME_IND;
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
   }
}
