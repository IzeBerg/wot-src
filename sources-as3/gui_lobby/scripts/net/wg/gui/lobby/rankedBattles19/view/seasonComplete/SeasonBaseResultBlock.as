package net.wg.gui.lobby.rankedBattles19.view.seasonComplete
{
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.components.data.RibbonAwardsVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesSeasonCompleteViewVO;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IFramesHelper;
   import scaleform.clik.constants.InvalidationType;
   
   public class SeasonBaseResultBlock extends UIComponentEx
   {
      
      private static const RESULT_PCT_CHAR:String = "%";
      
      private static const START_FRAME_LABEL:String = "start";
      
      private static const END_FRAME_LABEL:String = "end";
      
      private static const INV_FADE_IN:String = "invFadeIn";
       
      
      public var effectResult:SeasonResultRenderer;
      
      public var placeResult:SeasonPlaceResultRenderer;
      
      public var mainImage:SeasonMainImage;
      
      protected var data:RankedBattlesSeasonCompleteViewVO;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _frameHelper:IFramesHelper = null;
      
      private var _needFadeIn:Boolean = false;
      
      public function SeasonBaseResultBlock()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mainImage.addEventListener(MouseEvent.ROLL_OVER,this.onMainImageRollOverHandler);
         this.mainImage.addEventListener(MouseEvent.ROLL_OUT,this.onMainImageRollOutHandler);
         this.effectResult.endingChar = RESULT_PCT_CHAR;
         this._frameHelper = new FrameHelper(this);
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameBeforeLabel(END_FRAME_LABEL),this.onEndFadeInAnim);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateData();
               if(this._needFadeIn)
               {
                  invalidate(INV_FADE_IN);
               }
            }
            if(isInvalid(INV_FADE_IN))
            {
               this.effectResult.updateValue();
               this.placeResult.updateValue();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.mainImage.removeEventListener(MouseEvent.ROLL_OVER,this.onMainImageRollOverHandler);
         this.mainImage.removeEventListener(MouseEvent.ROLL_OUT,this.onMainImageRollOutHandler);
         this.mainImage.dispose();
         this.mainImage = null;
         this.effectResult.dispose();
         this.effectResult = null;
         this.placeResult.dispose();
         this.placeResult = null;
         this.data = null;
         this._tooltipMgr = null;
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameBeforeLabel(END_FRAME_LABEL),null);
         this._frameHelper.dispose();
         this._frameHelper = null;
         super.onDispose();
      }
      
      public function fadeIn() : void
      {
         this._needFadeIn = true;
         gotoAndPlay(START_FRAME_LABEL);
         invalidate(INV_FADE_IN);
      }
      
      public function setAwardsData(param1:RibbonAwardsVO) : void
      {
      }
      
      public function setData(param1:RankedBattlesSeasonCompleteViewVO) : void
      {
         if(param1 && this.data != param1)
         {
            this.data = param1;
            invalidateData();
         }
      }
      
      public function setPlace(param1:String) : void
      {
         this.placeResult.setValue(param1);
         this.placeResult.updateValue();
      }
      
      protected function updateData() : void
      {
         this.effectResult.setValue(this.data.effectValue);
         this.effectResult.setLabel(this.data.effectLabel);
         this.placeResult.setValue(this.data.placeValue);
         this.placeResult.setLabel(this.data.placeLabel);
         this.mainImage.setImage(this.data.mainImage);
      }
      
      protected function onEndFadeInAnim() : void
      {
      }
      
      private function onMainImageRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(this.data.tooltip);
      }
      
      private function onMainImageRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
