package net.wg.gui.lobby.vehicleTradeWnds.buy.popover
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import scaleform.clik.constants.InvalidationType;
   
   public class TradeInItemRenderer extends TableRenderer
   {
      
      private static const LEVEL_POS:int = 115;
       
      
      public var flagLoader:UILoaderAlt;
      
      public var tankIcon:UILoaderAlt;
      
      public var vehicleTypeIcon:MovieClip;
      
      public var levelIcon:MovieClip;
      
      public var selectedMc:MovieClip;
      
      public var selectedBg:MovieClip;
      
      public var vehicleNameTF:TextField;
      
      public var price:IconText;
      
      public var infoIcon:InfoIcon;
      
      public var hit:Sprite = null;
      
      private var _model:TradeInRendererVO;
      
      private const SELECTED_BACKGROUND_OFFSET:int = 11;
      
      public function TradeInItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._model = TradeInRendererVO(param1);
         invalidateData();
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         return statesDefault;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setSelectedVisible(selected && enabled);
         this.infoIcon.hit.buttonMode = true;
         this.hitArea = this.hit;
         mouseChildren = true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._model != null;
            if(_loc1_)
            {
               this.vehicleNameTF.htmlText = this._model.shortUserName;
               this.vehicleTypeIcon.gotoAndStop(this._model.type);
               this.levelIcon.gotoAndStop(this._model.level);
               this.levelIcon.x = LEVEL_POS - (this.levelIcon.width >> 1);
               this.flagLoader.source = App.utils.nations.getNationIcon(this._model.nationID);
               this.tankIcon.source = this._model.smallIconPath;
               this.price.text = this._model.price.toString();
               this.enabled = this._model.enabled;
               if(this._model.enabled)
               {
                  this.infoIcon.visible = false;
                  if(this._model.actionPrice != null)
                  {
                     this.infoIcon.visible = true;
                     this.infoIcon.addEventListener(MouseEvent.MOUSE_OVER,this.onInfoIconMouseOverHandler);
                     this.infoIcon.addEventListener(MouseEvent.MOUSE_OUT,this.onInfoIconMouseOutHandler);
                     this.infoIcon.addEventListener(MouseEvent.CLICK,this.onInfoIconClickHandler);
                  }
               }
               else
               {
                  this.infoIcon.visible = true;
                  this.infoIcon.tooltip = this._model.tooltip;
               }
            }
            visible = _loc1_;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.selectedMc.width = _width;
            this.selectedBg.width = _width + this.SELECTED_BACKGROUND_OFFSET;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.price.dispose();
         this.price = null;
         this.flagLoader.dispose();
         this.flagLoader = null;
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.infoIcon.removeEventListener(MouseEvent.MOUSE_OVER,this.onInfoIconMouseOverHandler);
         this.infoIcon.removeEventListener(MouseEvent.MOUSE_OUT,this.onInfoIconMouseOutHandler);
         this.infoIcon.removeEventListener(MouseEvent.CLICK,this.onInfoIconClickHandler);
         this.infoIcon.dispose();
         this.infoIcon = null;
         this.vehicleNameTF = null;
         this.levelIcon = null;
         this.vehicleTypeIcon = null;
         this.selectedMc = null;
         this.selectedBg = null;
         this._model = null;
         this.hit = null;
         super.onDispose();
      }
      
      public function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      public function showActionTooltip() : void
      {
         if(this._model && this._model.actionPrice)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,this._model.actionPrice.type,this._model.actionPrice.key,this._model.actionPrice.newPrices,this._model.actionPrice.oldPrices,this._model.actionPrice.isBuying,this._model.actionPrice.forCredits,this._model.actionPrice.rentPackage);
         }
      }
      
      private function setSelectedVisible(param1:Boolean) : void
      {
         this.selectedMc.visible = param1;
         this.selectedBg.visible = param1;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(param1 == super.selected)
         {
            return;
         }
         this.setSelectedVisible(param1 && enabled);
         super.selected = param1;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == super.enabled)
         {
            return;
         }
         super.enabled = buttonMode = param1;
         mouseChildren = true;
      }
      
      private function onInfoIconMouseOverHandler(param1:MouseEvent) : void
      {
         this.showActionTooltip();
      }
      
      private function onInfoIconMouseOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onInfoIconClickHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
   }
}
