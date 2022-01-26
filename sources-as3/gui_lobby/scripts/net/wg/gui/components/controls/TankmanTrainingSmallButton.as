package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.data.constants.TrainingType;
   import net.wg.gui.components.controls.price.Price;
   import net.wg.gui.lobby.tankman.vo.RetrainButtonVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class TankmanTrainingSmallButton extends SlotButtonBase
   {
      
      public static const DROP_SKILLS:String = "dropSkills";
      
      private static const RETRAINING_PREFIX:String = "retraining_";
      
      private static const INVALIDATE_TYPE:String = "invalidateType";
      
      private static const PRICE_OFFSET:int = 9;
      
      private static const TF_OFFSET:int = 2;
       
      
      public var bg:MovieClip;
      
      public var typeSwitcher:MovieClip;
      
      public var freeText:TextField;
      
      public var levelLabel:TextField;
      
      public var labelField:TextField;
      
      public var trainingLabel:TextField;
      
      public var price:Price;
      
      [Inspectable(defaultValue="buttonGroup",name="inspectableGroupName",verbose="1")]
      public var inspectableGroupName:String;
      
      private var _typedData:RetrainButtonVO;
      
      private var _type:String = "free";
      
      private var _scopeType:String = "";
      
      public function TankmanTrainingSmallButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.type = this._type;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_TYPE))
         {
            if(this._type == TrainingType.FREE)
            {
               this.price.visible = false;
               invalidateState();
            }
            else
            {
               this.price.visible = true;
               invalidateData();
            }
            this.freeText.visible = !this.price.visible;
            switch(this._scopeType)
            {
               case DROP_SKILLS:
                  this.labelField.text = MENU.skilldropwindow_study(this._type);
                  break;
               default:
                  this.labelField.text = MENU.tankmantrainingwindow(this._type);
            }
         }
         if(this._typedData && isInvalid(InvalidationType.DATA))
         {
            this.bg.gotoAndPlay(this._typedData.nation);
            this.levelLabel.text = this._typedData.level;
            this.typeSwitcher.gotoAndPlay(!!this._typedData.isNativeVehicle ? this._type : RETRAINING_PREFIX + this._type);
            this.trainingLabel.text = this._scopeType == DROP_SKILLS ? MENU.tankmantrainingwindow(this._type) : (!!this._typedData.isNativeVehicle ? MENU.TANKMANTRAININGBUTTON2_TRAININGTO : MENU.TANKMANTRAININGBUTTON2_RETRAININGTO);
            if(this.price.visible)
            {
               this.price.setData(this._typedData.price);
               this.price.isEnough = this._typedData.isMoneyEnough;
               this.price.actionMode = !!this._typedData.showAction ? Price.ACTION_MODE_ALWAYS_SHOW : Price.ACTION_MODE_DISABLED;
               this.price.mouseEnabled = this.price.mouseChildren = this._typedData.showAction;
               this.price.visible = true;
               this.price.validateNow();
               this.price.x = width - this.price.width - PRICE_OFFSET;
            }
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.freeText.visible = !this.price.visible;
            if(this.freeText.visible)
            {
               this.freeText.text = MENU.TANKMANRETRAININGBTN_FREE;
               this.freeText.autoSize = TextFieldAutoSize.LEFT;
               this.freeText.x = width - this.freeText.width - PRICE_OFFSET - TF_OFFSET;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.price.dispose();
         this.price = null;
         this.bg = null;
         this.freeText = null;
         this.levelLabel = null;
         this.labelField = null;
         this.trainingLabel = null;
         this.typeSwitcher = null;
         this._typedData = null;
         super.onDispose();
      }
      
      public function setData(param1:RetrainButtonVO) : void
      {
         this._typedData = param1;
         this.enabled = param1.enabled;
         invalidateData();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
      
      [Inspectable(defaultValue="false",verbose="1")]
      public function get scopeType() : String
      {
         return this._scopeType;
      }
      
      public function set scopeType(param1:String) : void
      {
         if(this._scopeType == param1)
         {
            return;
         }
         this._scopeType = param1;
         invalidate(INVALIDATE_TYPE);
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      [Inspectable(defaultValue="free",enumeration="free, scool, academy",verbose="1")]
      public function set type(param1:String) : void
      {
         if(this._type == param1)
         {
            return;
         }
         this._type = param1;
         invalidate(INVALIDATE_TYPE);
      }
   }
}
