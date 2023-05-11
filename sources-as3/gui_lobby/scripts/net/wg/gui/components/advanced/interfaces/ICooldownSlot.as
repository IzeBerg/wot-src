package net.wg.gui.components.advanced.interfaces
{
   import flash.display.DisplayObject;
   import net.wg.gui.interfaces.ISoundButton;
   
   public interface ICooldownSlot extends ISoundButton
   {
       
      
      function clearCoolDownTime() : void;
      
      function setCoolDownPosAsPercent(param1:Number) : void;
      
      function setCooldown(param1:Number) : void;
      
      function get id() : String;
      
      function set id(param1:String) : void;
      
      function get icon() : String;
      
      function set icon(param1:String) : void;
      
      function get isDischarging() : Boolean;
      
      function set isDischarging(param1:Boolean) : void;
      
      function get isCooolDownInProgress() : Boolean;
      
      function get isInactive() : Boolean;
      
      function set isInactive(param1:Boolean) : void;
      
      function get onlyLeftButton() : Boolean;
      
      function set onlyLeftButton(param1:Boolean) : void;
      
      function get displayObject() : DisplayObject;
   }
}
