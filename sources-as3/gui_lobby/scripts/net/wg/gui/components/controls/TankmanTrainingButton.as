package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.Colors;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.IconsTypes;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.data.constants.TrainingType;
   import net.wg.utils.ILocale;
   import net.wg.utils.INations;
   
   public class TankmanTrainingButton extends SlotButtonBase
   {
      
      private static const INV_NATION:String = "invalidNation";
      
      private static const INV_TYPE:String = "invalidType";
      
      private static const INV_PRICE_PROPS:String = "invalidPriceProps";
      
      private static const PRICE_LABEL_COLOR_DISABLED:int = Colors.ERROR_COLOR;
      
      private static const PRICE_LABEL_COLOR_NORMAL:int = 16314069;
      
      private static const BG_LABEL_EMPTY:String = "empty";
       
      
      public var bg:MovieClip;
      
      public var typeSwitcher:MovieClip;
      
      public var priceLabel:IconText = null;
      
      public var actionPrice:ActionPrice;
      
      public var typeLabel:TextField;
      
      public var trainingToText:TextField;
      
      private var _nations:INations;
      
      private var _locale:ILocale;
      
      private var _buy:Boolean;
      
      private var _nation:uint;
      
      private var _type:String = "free";
      
      private var _showPriceLabel:Boolean = true;
      
      public function TankmanTrainingButton()
      {
         this._nations = App.utils.nations;
         this._locale = App.utils.locale;
         super();
         _stateMap["buy"] = [ComponentState.BUY];
      }
      
      override public function toString() : String
      {
         return "[Wargaming TankmanTrainingButton " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         this.actionPrice.dispose();
         this.actionPrice = null;
         this.priceLabel.dispose();
         this.priceLabel = null;
         this.typeSwitcher = null;
         this.typeLabel = null;
         this.trainingToText = null;
         this.bg = null;
         this._nations = null;
         this._locale = null;
         super.onDispose();
      }
      
      override protected function handlePress(param1:uint = 0) : void
      {
         if(!this._buy)
         {
            super.handlePress(param1);
         }
      }
      
      override protected function handleRelease(param1:uint = 0) : void
      {
         if(!this._buy)
         {
            super.handleRelease(param1);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.trainingToText.text = MENU.TANKMANTRAININGWINDOW_TRAININGTO;
         this.actionPrice.setup(this,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_NATION))
         {
            this.bg.gotoAndPlay(!isNaN(this._nation) ? this._nations.getNationName(this._nation) : BG_LABEL_EMPTY);
         }
         if(isInvalid(INV_TYPE))
         {
            if(this._type == TrainingType.FREE)
            {
               this.priceLabel.visible = false;
               if(this.actionPrice)
               {
                  this.actionPrice.visible = false;
               }
            }
            else if(this.actionPrice)
            {
               this.priceLabel.visible = !this.actionPrice.visible;
            }
            else
            {
               this.priceLabel.visible = true;
            }
            this.typeLabel.text = MENU.tankmantrainingwindow(this._type);
            this.typeSwitcher.gotoAndPlay(this._type);
         }
         if(isInvalid(INV_PRICE_PROPS))
         {
            this.priceLabel.textColor = !enabled ? Number(PRICE_LABEL_COLOR_DISABLED) : Number(PRICE_LABEL_COLOR_NORMAL);
            this.actionPrice.textColorType = !enabled ? ActionPrice.TEXT_COLOR_TYPE_ERROR : ActionPrice.TEXT_COLOR_TYPE_ICON;
            if(!this._showPriceLabel)
            {
               this.actionPrice.visible = this.priceLabel.visible = this._showPriceLabel;
            }
         }
      }
      
      public function updatePrice(param1:Number, param2:String, param3:ActionPriceVO = null) : void
      {
         if(!this._buy && this._type != TrainingType.FREE)
         {
            this.priceLabel.text = this._type == TrainingType.ACADEMY ? this._locale.gold(param1) : this._locale.integer(param1);
            this.priceLabel.icon = this._type == TrainingType.ACADEMY ? IconsTypes.GOLD : IconsTypes.CREDITS;
            if(param3)
            {
               param3.ico = param2;
            }
            this.actionPrice.setData(param3);
            this.priceLabel.visible = !this.actionPrice.visible;
            invalidate(INV_PRICE_PROPS);
         }
         else
         {
            this.priceLabel.visible = false;
            this.actionPrice.visible = false;
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(enabled == param1)
         {
            return;
         }
         super.enabled = param1;
         invalidate(INV_PRICE_PROPS);
      }
      
      [Inspectable(defaultValue="false",verbose="1")]
      public function get buy() : Boolean
      {
         return this._buy;
      }
      
      public function set buy(param1:Boolean) : void
      {
         if(this._buy == param1)
         {
            return;
         }
         this._buy = param1;
         this.priceLabel.visible = !this._buy && this._type != TrainingType.FREE && !this.actionPrice.visible;
         if(this._buy || this._type == TrainingType.FREE)
         {
            this.actionPrice.visible = false;
         }
         clearRepeatInterval();
         setState(!!this._buy ? ComponentState.BUY : ComponentState.UP);
      }
      
      public function get nation() : uint
      {
         return this._nation;
      }
      
      public function set nation(param1:uint) : void
      {
         if(this._nation == param1)
         {
            return;
         }
         this._nation = param1;
         invalidate(INV_NATION);
      }
      
      [Inspectable(defaultValue="free",enumeration="free, scool, academy",verbose="1")]
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         if(this._type != param1)
         {
            this._type = param1;
            invalidate(INV_TYPE);
         }
      }
      
      public function set showPriceLabel(param1:Boolean) : void
      {
         if(this._showPriceLabel == param1)
         {
            return;
         }
         this._showPriceLabel = param1;
         invalidate(INV_PRICE_PROPS);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         if(!this._buy)
         {
            super.handleMouseRollOver(param1);
         }
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         if(!this._buy)
         {
            super.handleMouseRollOut(param1);
         }
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         if(!this._buy)
         {
            super.handleMousePress(param1);
         }
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(!this._buy)
         {
            super.handleMouseRelease(param1);
         }
      }
      
      override protected function handleReleaseOutside(param1:MouseEvent) : void
      {
         if(!this._buy)
         {
            super.handleReleaseOutside(param1);
         }
      }
   }
}
