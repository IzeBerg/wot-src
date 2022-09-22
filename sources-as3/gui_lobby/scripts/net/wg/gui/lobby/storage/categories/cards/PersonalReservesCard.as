package net.wg.gui.lobby.storage.categories.cards
{
   import flash.display.Graphics;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class PersonalReservesCard extends BaseCard
   {
      
      public static const IMAGE_DISABLE_ALPHA:Number = 0.5;
      
      public static const ITEMS_DISABLE_ALPHA:Number = 0.7;
      
      public static const ALERT_TOP:int = 10;
       
      
      public var disabled:BitmapFill;
      
      public var activatedTF:TextField;
      
      public var disabledTF:TextField;
      
      public var alertTF:TextField;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function PersonalReservesCard()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.disabled.dispose();
         this.disabled = null;
         this.activatedTF = null;
         this.alertTF = null;
         this.disabledTF = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.activatedTF.mouseEnabled = this.activatedTF.mouseWheelEnabled = false;
         this.activatedTF.text = STORAGE.PERSONALRESERVES_CARD_ACTIVATED;
         this.activatedTF.autoSize = TextFieldAutoSize.LEFT;
         this.disabledTF.mouseEnabled = this.disabledTF.mouseWheelEnabled = false;
         this.disabledTF.text = STORAGE.PERSONALRESERVES_CARD_NOTAVAILABLE;
         this.disabledTF.autoSize = TextFieldAutoSize.LEFT;
         sellButton.label = STORAGE.BUTTONLABEL_ACTIVATE;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Graphics = null;
         if(_data && isInvalid(InvalidationType.DATA))
         {
            buttonMode = _data.enabled;
            titleTF.htmlText = _data.title;
            descriptionTF.htmlText = _data.description;
            descriptionTF.alpha = 1;
            this.alertTF.alpha = 0;
            this.alertTF.autoSize = TextFieldAutoSize.RIGHT;
            this.alertTF.htmlText = _data.additionalInfo;
            inInventoryCountTF.visible = inInventoryIcon.visible = _data.count > 0;
            inInventoryCountTF.text = _data.count.toString();
            this.activatedTF.visible = _data.active;
            this.disabledTF.visible = !_data.available;
            sellButton.visible = _data.enabled;
            if(_resetViewOnDataChange)
            {
               sellButton.alpha = 0;
               _overlay.alpha = 0;
            }
            if(_data.enabled)
            {
               this.disabled.visible = false;
               titleTF.alpha = descriptionTF.alpha = inInventoryCountTF.alpha = inInventoryIcon.alpha = 1;
               mouseChildren = buttonMode = true;
            }
            else
            {
               this.disabled.visible = true;
               titleTF.alpha = descriptionTF.alpha = inInventoryCountTF.alpha = inInventoryIcon.alpha = ITEMS_DISABLE_ALPHA;
               mouseChildren = buttonMode = false;
            }
            invalidateSize();
         }
         if(_data && isInvalid(InvalidationType.SIZE))
         {
            if(_resetViewOnDataChange)
            {
               disposeTweens();
            }
            if(image.source != _data.image)
            {
               image.alpha = 0;
               image.sourceAlt = _data.imageAlt;
               image.source = _data.image;
            }
            else
            {
               image.alpha = !!_data.enabled ? Number(1) : Number(IMAGE_DISABLE_ALPHA);
            }
            _loc1_ = _sizeVO.innerPadding;
            _loc2_ = graphics;
            _loc2_.clear();
            _loc2_.lineStyle(1,16777215,0.15);
            _loc2_.beginFill(0,0.25);
            _loc2_.drawRoundRect(BORDER_OFFSET,BORDER_OFFSET,width - BORDER_SIZE_CORRECTION,height - BORDER_SIZE_CORRECTION,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
            _loc2_.endFill();
            _overlay.alpha = 0;
            _loc2_ = _overlay.graphics;
            _loc2_.clear();
            _loc2_.beginFill(1973272);
            _loc2_.drawRoundRect(OVERLAY_OFFSET,OVERLAY_OFFSET,width - OVERLAY_SIZE_CORRECTION,height - OVERLAY_SIZE_CORRECTION,BORDER_CORNER_RADIUS,BORDER_CORNER_RADIUS);
            _loc2_.endFill();
            this.disabled.widthFill = _overlay.width;
            this.disabled.heightFill = _overlay.height;
            inInventoryCountTF.x = _loc1_.right - inInventoryCountTF.width >> 0;
            inInventoryCountTF.y = _loc1_.bottom - inInventoryCountTF.height >> 0;
            inInventoryIcon.x = inInventoryCountTF.x - inInventoryIcon.width - ININVENTORY_ICON_OFFSET;
            inInventoryIcon.y = inInventoryCountTF.y - ININVENTORY_ICON_OFFSET;
            titleTF.x = _loc1_.left;
            titleTF.width = !inInventoryIcon.visible ? Number(_loc1_.width) : Number(inInventoryIcon.x - titleTF.x);
            descriptionTF.x = _loc1_.left;
            descriptionTF.y = titleTF.y + titleTF.height + _sizeVO.descriptionOffset;
            descriptionTF.width = _loc1_.width >> 0;
            this.alertTF.x = _loc1_.right - this.alertTF.width;
            this.alertTF.y = ALERT_TOP;
            _container.y = this.getContainerYRolloutPosition();
            this.disabledTF.x = this.activatedTF.x = _loc1_.left;
            this.disabledTF.y = this.activatedTF.y = ALERT_TOP;
            sellButton.x = _loc1_.right - sellButton.width >> 0;
            sellButton.y = _loc1_.bottom - sellButton.height >> 0;
            sellButton.alpha = 0;
            onImageComplete();
         }
      }
      
      override protected function getRollOverTweens() : Vector.<Tween>
      {
         var _loc1_:int = height - _container.height >> 1;
         if(sellButton.visible && _loc1_ + _container.height > sellButton.y)
         {
            _loc1_ = sellButton.y - _container.height >> 1;
         }
         return new <Tween>[new Tween(FIRST_ANIMATION_DURATION,_container,{"y":_loc1_},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         }),new Tween(FIRST_ANIMATION_DURATION,_overlay,{"alpha":1},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         }),new Tween(FIRST_ANIMATION_DURATION,inInventoryCountTF,{"alpha":0},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         }),new Tween(FIRST_ANIMATION_DURATION,inInventoryIcon,{"alpha":0},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         }),new Tween(FIRST_ANIMATION_DURATION,image,{"alpha":0.1},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         }),new Tween(FIRST_ANIMATION_DURATION,sellButton,{"alpha":1},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY + FIRST_ANIMATION_DURATION
         }),new Tween(FIRST_ANIMATION_DURATION,this.alertTF,{"alpha":1},{
            "fastTransform":false,
            "delay":ROLL_OVER_ANIMATION_DELAY
         })];
      }
      
      override protected function getRollOutTweens() : Vector.<Tween>
      {
         var _loc1_:Number = !!_data.enabled ? Number(1) : Number(ITEMS_DISABLE_ALPHA);
         return new <Tween>[new Tween(FIRST_ANIMATION_DURATION,_container,{"y":this.getContainerYRolloutPosition()},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,_overlay,{"alpha":0},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,inInventoryCountTF,{"alpha":_loc1_},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,inInventoryIcon,{"alpha":_loc1_},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,image,{"alpha":(!!_data.enabled ? 1 : 0.3)},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,sellButton,{"alpha":0},{"fastTransform":false}),new Tween(FIRST_ANIMATION_DURATION,this.alertTF,{"alpha":0},{"fastTransform":false})];
      }
      
      override protected function getContainerYRolloutPosition() : int
      {
         return _sizeVO.innerPadding.bottom - _container.height >> 0;
      }
      
      override protected function animateImage() : void
      {
         if(_data.enabled)
         {
            super.animateImage();
         }
         else
         {
            image.alpha = IMAGE_DISABLE_ALPHA;
         }
      }
      
      override protected function onRollOver() : void
      {
         if(_data == null || _data.enabled)
         {
            super.onRollOver();
         }
         else if(_data.available)
         {
            this._toolTipMgr.show(TOOLTIPS.BOOSTER_ACTIVEBTN_DISABLED_BODY);
         }
         else
         {
            this._toolTipMgr.show(TOOLTIPS.BOOSTER_ACTIVEBTN_NOTAVAILABLE_BODY);
         }
      }
      
      override protected function onRollOut() : void
      {
         if(_data == null || _data.enabled)
         {
            super.onRollOut();
         }
         else
         {
            this._toolTipMgr.hide();
         }
      }
   }
}
