package net.wg.infrastructure.managers.impl
{
   import net.wg.infrastructure.interfaces.ICustomObjectFinder;
   
   public class TutorialManagerBattle extends TutorialManager
   {
       
      
      public function TutorialManagerBattle(param1:ICustomObjectFinder)
      {
         super(param1);
      }
      
      override public function get isSystemEnabled() : Object
      {
         return false;
      }
   }
}
