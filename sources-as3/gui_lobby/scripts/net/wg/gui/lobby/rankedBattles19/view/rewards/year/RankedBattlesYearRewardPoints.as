package net.wg.gui.lobby.rankedBattles19.view.rewards.year
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.lobby.rankedBattles19.data.RankedRewardYearItemPointsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedBattlesYearRewardPoints extends UIComponentEx
   {
      
      private static const GAP:int = 5;
       
      
      public var pointsTf:TextField = null;
      
      public var pointsImg:IImage = null;
      
      private var _data:RankedRewardYearItemPointsVO = null;
      
      public function RankedBattlesYearRewardPoints()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.pointsImg.addEventListener(Event.CHANGE,this.onPointsImgChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.pointsTf.htmlText = this._data.text;
               this.pointsImg.source = this._data.image;
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               App.utils.commons.updateTextFieldSize(this.pointsTf);
               this.pointsTf.x = -(this.pointsTf.width + this.pointsImg.width + GAP) >> 1;
               this.pointsTf.y = -this.pointsTf.height >> 1;
               this.pointsImg.x = this.pointsTf.x + this.pointsTf.width + GAP | 0;
               this.pointsImg.y = -this.pointsImg.height >> 1;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         hitArea = null;
         this.pointsImg.removeEventListener(Event.CHANGE,this.onPointsImgChangeHandler);
         this.pointsImg.dispose();
         this.pointsImg = null;
         this.pointsTf = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:RankedRewardYearItemPointsVO) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      private function onPointsImgChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
