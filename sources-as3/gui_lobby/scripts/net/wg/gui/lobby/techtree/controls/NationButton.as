package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class NationButton extends SoundButtonEx
   {
      
      private static const ARROW_OFFSET:int = 12;
      
      private static const DEFAULT_CONTENT_SIZE:Rectangle = new Rectangle();
      
      private static const DISCOUNT_OFFSET_X:int = 23;
      
      private static const DISCOUNT_OFFSET_Y:int = 7;
       
      
      public var borderStates:NationButtonStates;
      
      public var arrowMc:MovieClip;
      
      public var discount:Sprite;
      
      private var _flagScale:Number = 1;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _isTooltipSpecial:Boolean = false;
      
      public function NationButton()
      {
         super();
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
         soundType = SoundTypes.TAB;
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override protected function onDispose() : void
      {
         this.borderStates.dispose();
         this.borderStates = null;
         this.discount = null;
         this.arrowMc = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Rectangle = null;
         if(_baseDisposed)
         {
            return;
         }
         if(this.borderStates != null && isInvalid(InvalidationType.STATE))
         {
            if(StringUtils.isNotEmpty(_newFrame))
            {
               App.utils.asserter.assert(_labelHash.hasOwnProperty(_newFrame),Errors.WASNT_FOUND);
               this.borderStates.gotoAndPlay(_newFrame);
               if(_baseDisposed)
               {
                  return;
               }
            }
         }
         super.draw();
         if(_label != null && this.borderStates != null && isInvalid(InvalidationType.DATA))
         {
            this.borderStates.setIconState(_label);
            if(_baseDisposed)
            {
               return;
            }
         }
         if(this.borderStates && isInvalid(InvalidationType.LAYOUT))
         {
            _loc1_ = this.borderStates.contentSize;
            this.borderStates.scaleX = (_originalWidth - _loc1_.width + this._flagScale * _loc1_.width) / _originalWidth;
            this.borderStates.scaleY = (_originalHeight - _loc1_.height + this._flagScale * _loc1_.height) / _originalHeight;
            if(this.arrowMc)
            {
               this.arrowMc.x = (_loc1_.width * (1 + this._flagScale) >> 1) + ARROW_OFFSET;
            }
            this.discount.x = _loc1_.width * (1 + this._flagScale) * 0.5 - this.discount.width + DISCOUNT_OFFSET_X;
            this.discount.y = -_loc1_.height * this._flagScale * 0.5 + DISCOUNT_OFFSET_Y;
         }
      }
      
      override protected function showTooltip() : void
      {
         if(!_selected && this._tooltipMgr != null && StringUtils.isNotEmpty(_tooltip))
         {
            if(this._isTooltipSpecial)
            {
               this._tooltipMgr.showSpecial(_tooltip,null,_label);
            }
            else
            {
               this._tooltipMgr.showComplex(this._tooltipMgr.getNewFormatter().addHeader(TOOLTIPS.techtreepage_nations(_tooltip),true).make());
            }
         }
      }
      
      public function setDiscountVisible(param1:Boolean) : void
      {
         this.discount.visible = param1;
      }
      
      public function setFlagScale(param1:Number) : void
      {
         if(this._flagScale != param1)
         {
            this._flagScale = param1;
            invalidateLayout();
         }
      }
      
      public function get contentSize() : Rectangle
      {
         return Boolean(this.borderStates) ? this.borderStates.contentSize : DEFAULT_CONTENT_SIZE;
      }
      
      public function set isTooltipSpecial(param1:Boolean) : void
      {
         this._isTooltipSpecial = param1;
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(!_selected)
         {
            super.handleMouseRelease(param1);
         }
      }
   }
}
