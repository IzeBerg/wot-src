package net.wg.infrastructure.managers.impl
{
   import net.wg.gui.components.containers.ManagedContainer;
   
   public class ContainerManagerBattle extends ContainerManagerBase
   {
       
      
      public function ContainerManagerBattle()
      {
         super();
      }
      
      override public function as_isContainerShown(param1:int) : Boolean
      {
         assert(_containersMap[param1] != null,"ContainerManagerBattle does not have container for layer " + param1);
         var _loc2_:ManagedContainer = _containersMap[param1] as ManagedContainer;
         return Boolean(_loc2_) ? Boolean(_loc2_.visible) : Boolean(false);
      }
      
      override protected function showContainers(param1:Vector.<int>, param2:int) : void
      {
         this.setVisibility(param1,true);
      }
      
      override protected function hideContainers(param1:Vector.<int>, param2:int) : void
      {
         this.setVisibility(param1,false);
      }
      
      private function setVisibility(param1:Vector.<int>, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ManagedContainer = null;
         for each(_loc3_ in param1)
         {
            assert(_containersMap[_loc3_] != null,"ContainerManagerBattle does not have container for layer " + _loc3_);
            _loc4_ = _containersMap[_loc3_] as ManagedContainer;
            if(_loc4_)
            {
               _loc4_.visible = param2;
            }
         }
      }
   }
}
