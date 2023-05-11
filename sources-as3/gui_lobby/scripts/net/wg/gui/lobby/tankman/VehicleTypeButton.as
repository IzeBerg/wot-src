package net.wg.gui.lobby.tankman
{
   import flash.display.MovieClip;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.controls.SoundButtonEx;
   
   [InspectableList("soundId")]
   public class VehicleTypeButton extends SoundButtonEx
   {
       
      
      public var typeSwitcher:MovieClip;
      
      public var _type:String = "free";
      
      [Inspectable(defaultValue="buttonGroup",name="inspectableGroupName",verbose="1")]
      public var inspectableGroupName:String;
      
      public function VehicleTypeButton()
      {
         super();
         soundType = SoundTypes.RNDR_NORMAL;
         preventAutosizing = true;
         constraintsDisabled = true;
      }
      
      override protected function onDispose() : void
      {
         this.typeSwitcher = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.typeSwitcher.mouseEnabled = false;
         toggle = false;
      }
      
      [Inspectable(defaultValue="lightTank",enumeration="lightTank, mediumTank, heavyTank, AT-SPG, SPG",verbose="1")]
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         if(this._type == param1)
         {
            return;
         }
         this._type = param1;
         this.typeSwitcher.gotoAndStop(param1);
      }
   }
}
