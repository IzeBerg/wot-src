package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import net.wg.gui.components.controls.DropDownListItemRendererSound;
   import net.wg.infrastructure.base.interfaces.IAbstractPopOverView;
   import net.wg.infrastructure.interfaces.IContextMenu;
   import net.wg.infrastructure.interfaces.IPopoverWrapper;
   import net.wg.infrastructure.interfaces.IView;
   
   public class PopoverManagerBattle extends PopoverManagerBase
   {
       
      
      public function PopoverManagerBattle(param1:Stage)
      {
         super(param1);
      }
      
      override public function isPopover(param1:IView) : Boolean
      {
         return param1 is IAbstractPopOverView;
      }
      
      override protected function isCheckingCandidateValid(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject) : Boolean
      {
         while(param1)
         {
            if(param1 == param3 || param1 == param2 || param1 is IPopoverWrapper || param1 is IAbstractPopOverView || param1 is IContextMenu || param1 is DropDownListItemRendererSound)
            {
               return false;
            }
            param1 = param1.parent;
         }
         return true;
      }
   }
}
