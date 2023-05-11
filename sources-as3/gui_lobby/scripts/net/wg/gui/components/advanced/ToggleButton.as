package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.ButtonIconLoader;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Padding;
   
   public class ToggleButton extends ButtonIconLoader
   {
      
      public static const FLAGS_SOURCE:String = "../maps/icons/filters/nations/";
       
      
      public var rFlagsFrame:Sprite;
      
      public var vType:MovieClip;
      
      public var sizeArea:MovieClip;
      
      public var hightLight:MovieClip;
      
      public var toggleBg:MovieClip;
      
      private var _vehicleType:String = null;
      
      private var _nationFlag:String = null;
      
      private var _buttonCursor:Boolean = false;
      
      public function ToggleButton()
      {
         super();
         this.rFlagsFrame.visible = false;
         this.vType.visible = false;
         disabledFillPadding = new Padding(2,0,2,0);
         _data = {};
         this.hightLight.visible = false;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
      }
      
      [Inspectable(defaultValue="none",enumeration="none,lightTank,mediumTank,heavyTank,AT-SPG,SPG")]
      public function get vehicleType() : String
      {
         return this._vehicleType;
      }
      
      public function set vehicleType(param1:String) : void
      {
         if(param1 && (param1 != "" && param1 != "none"))
         {
            this._vehicleType = param1;
            this.rFlagsFrame.visible = false;
            this.changeViewState(true);
         }
      }
      
      [Inspectable(defaultValue="none",enumeration="none,ussr,germany,usa,china,france,uk,japan")]
      public function get nationFlag() : String
      {
         return this._nationFlag;
      }
      
      public function set nationFlag(param1:String) : void
      {
         if(param1 && (param1 != "" && param1 != "none"))
         {
            this._nationFlag = param1;
            _data = this._nationFlag;
            iconSource = FLAGS_SOURCE + this._nationFlag + ".png";
            this.rFlagsFrame.visible = true;
            this.changeViewState(false);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.sizeArea.visible = false;
         buttonMode = true;
         this._buttonCursor = false;
         mouseChildren = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE) && this.hightLight)
         {
            this.hightLight.visible = selected;
         }
      }
      
      protected function changeViewState(param1:Boolean) : void
      {
         this.vType.visible = param1;
         if(param1)
         {
            this.vType.gotoAndStop(this.vehicleType);
            _data = this.vehicleType;
         }
      }
      
      override protected function configIcon() : void
      {
         if(container && loader)
         {
            container.x = Math.floor((hitArea.width - loader.width) / 2 + _iconOffsetLeft);
            container.y = Math.floor((hitArea.height - loader.height) / 2 + _iconOffsetTop);
         }
      }
      
      override protected function updateDisable() : void
      {
         if(disableMc != null)
         {
            disableMc.x = disabledFillPadding.left;
            disableMc.y = disabledFillPadding.top;
            disableMc.scaleX = 1 / this.scaleX;
            disableMc.scaleY = 1 / this.scaleY;
            disableMc.widthFill = Math.round(this.toggleBg.width * this.scaleX) - disabledFillPadding.horizontal;
            disableMc.heightFill = Math.round(this.toggleBg.height * this.scaleY) - disabledFillPadding.vertical;
            disableMc.visible = !enabled;
         }
      }
   }
}
