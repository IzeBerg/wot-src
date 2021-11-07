package net.wg.gui.components.containers
{
   import flash.display.DisplayObjectContainer;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonGroup;
   
   public class ButtonGroupEx extends ButtonGroup
   {
       
      
      public function ButtonGroupEx(param1:String, param2:DisplayObjectContainer)
      {
         super(param1,param2);
      }
      
      public static function getGroup(param1:String, param2:DisplayObjectContainer) : ButtonGroupEx
      {
         var _loc3_:Object = groups[param2];
         if(_loc3_ == null)
         {
            _loc3_ = groups[param2] = new Object();
         }
         var _loc4_:ButtonGroupEx = _loc3_[App.utils.toUpperOrLowerCase(param1,false)];
         if(_loc4_ == null)
         {
            _loc4_ = _loc3_[App.utils.toUpperOrLowerCase(param1,false)] = new ButtonGroupEx(param1,param2);
         }
         return _loc4_;
      }
      
      override public function removeButton(param1:Button) : void
      {
         super.removeButton(param1);
         if(param1 == selectedButton)
         {
            selectedButton = null;
         }
      }
   }
}
