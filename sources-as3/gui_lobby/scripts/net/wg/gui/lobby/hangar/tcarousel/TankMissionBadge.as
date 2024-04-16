package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class TankMissionBadge extends UIComponentEx
   {
      
      private static const OFFSET_X_BIG:int = 113;
      
      private static const OFFSET_X_SMALL:int = 112;
      
      private static const PADDING_LEFT_SMALL:int = 38;
      
      private static const OFFSET_Y_BIG:int = 0;
      
      private static const OFFSET_Y_SMALL:int = 2;
      
      private static const PADDING_TOP_BIG:int = 16;
      
      private static const ALPHA_NORMAL:Number = 1;
      
      private static const ALPHA_HOVER:Number = 0.4;
       
      
      public var imgXp:Image = null;
      
      public var imgDebutBoxes:Image = null;
      
      private var _dataVO:VehicleCarouselVO = null;
      
      private var _isSmall:Boolean = false;
      
      private var _hasXpImg:Boolean = false;
      
      private var _hasDebutBoxImg:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _isLocked:Boolean = false;
      
      private var _isInfoVisible:Boolean = false;
      
      private var _isSlotHover:Boolean = false;
      
      public function TankMissionBadge()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         mouseEnabled = false;
         this.imgXp.buttonMode = true;
         this.imgDebutBoxes.buttonMode = true;
         this._toolTipMgr = App.toolTipMgr;
         this.addListeners();
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this._dataVO = null;
         this._toolTipMgr = null;
         this.imgXp.dispose();
         this.imgXp = null;
         this.imgDebutBoxes.dispose();
         this.imgDebutBoxes = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:Boolean = isInvalid(InvalidationType.STATE);
         var _loc2_:Boolean = isInvalid(InvalidationType.LAYOUT);
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateData();
            _loc1_ = true;
            _loc2_ = true;
         }
         if(_loc1_)
         {
            this.updateState();
         }
         if(_loc2_)
         {
            this.updateLayout();
         }
      }
      
      private function addListeners() : void
      {
         this.imgXp.addEventListener(MouseEvent.MOUSE_OVER,this.onImgXpMouseOverHandler);
         this.imgXp.addEventListener(MouseEvent.MOUSE_OUT,this.onImgXpMouseOutHandler);
         this.imgDebutBoxes.addEventListener(MouseEvent.MOUSE_OVER,this.onDebutBoxMouseOverHandler);
         this.imgDebutBoxes.addEventListener(MouseEvent.MOUSE_OUT,this.onDebutBoxMouseOutHandler);
      }
      
      private function removeListeners() : void
      {
         this.imgXp.removeEventListener(MouseEvent.MOUSE_OVER,this.onImgXpMouseOverHandler);
         this.imgXp.removeEventListener(MouseEvent.MOUSE_OUT,this.onImgXpMouseOutHandler);
         this.imgDebutBoxes.removeEventListener(MouseEvent.MOUSE_OVER,this.onDebutBoxMouseOverHandler);
         this.imgDebutBoxes.removeEventListener(MouseEvent.MOUSE_OUT,this.onDebutBoxMouseOutHandler);
      }
      
      public function setData(param1:VehicleCarouselVO) : void
      {
         this._dataVO = param1;
         invalidateData();
      }
      
      private function updateData() : void
      {
         if(this._dataVO == null || this._dataVO.buySlot || this._dataVO.buyTank || this._dataVO.restoreTank)
         {
            this._isInfoVisible = false;
            return;
         }
         this._hasXpImg = !StringUtils.isEmpty(this._dataVO.xpImgSource);
         this._hasDebutBoxImg = !StringUtils.isEmpty(this._dataVO.debutBoxesImgSource);
         if(!this._hasXpImg && !this._hasDebutBoxImg)
         {
            this._isInfoVisible = false;
            return;
         }
         this.imgXp.source = this._dataVO.xpImgSource;
         this.imgDebutBoxes.source = this._dataVO.debutBoxesImgSource;
         this._isLocked = this._dataVO.lockBackground;
         this._isInfoVisible = !this._dataVO.isWotPlusSlot || this._dataVO.intCD > 0;
      }
      
      private function updateState() : void
      {
         mouseChildren = this._isInfoVisible && !this._isLocked;
         var _loc1_:Boolean = !this._isInfoVisible || this._isSmall && this._isLocked && this._isSlotHover;
         this.imgXp.visible = this.imgDebutBoxes.visible = !_loc1_;
         if(!_loc1_)
         {
            this.imgXp.alpha = this.imgDebutBoxes.alpha = !!this._isLocked ? Number(ALPHA_HOVER) : Number(ALPHA_NORMAL);
         }
      }
      
      private function updateLayout() : void
      {
         if(this._isSmall)
         {
            this.imgXp.x = this.imgDebutBoxes.x = OFFSET_X_SMALL;
            this.imgXp.y = this.imgDebutBoxes.y = OFFSET_Y_SMALL;
            if(this._hasXpImg)
            {
               this.imgDebutBoxes.x -= PADDING_LEFT_SMALL;
            }
         }
         else
         {
            this.imgXp.x = this.imgDebutBoxes.x = OFFSET_X_BIG;
            this.imgXp.y = this.imgDebutBoxes.y = OFFSET_Y_BIG;
            if(this._hasXpImg)
            {
               this.imgDebutBoxes.y += PADDING_TOP_BIG;
            }
         }
      }
      
      public function handleSlotRollOver() : void
      {
         this._isSlotHover = true;
         invalidateState();
      }
      
      public function handleSlotRollOut() : void
      {
         this._isSlotHover = false;
         invalidateState();
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            invalidateLayout();
         }
      }
      
      private function onImgXpMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(TOOLTIPS.TANKCARUSEL_XPMULTIPLIER);
      }
      
      private function onImgXpMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onDebutBoxMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.DEBUT_BOXES_BADGE,this._dataVO.intCD);
      }
      
      private function onDebutBoxMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
