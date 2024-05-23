package net.wg.gui.lobby.techtree.data.state
{
   public class UnlockedStateItem extends NodeStateItem
   {
      
      private static const ROOT_INVENTORY_INFO_FIELD:String = "isRootInInventory";
      
      private static const PARENT_UNLOCKED_INFO_FIELD:String = "isParentUnlocked";
      
      public static const RESEARCH_GRAPH:String = "isResearchGraph";
       
      
      private var _availableForBuy:StateProperties;
      
      public function UnlockedStateItem(param1:StateProperties, param2:StateProperties, param3:uint = 4)
      {
         super(param3,param1);
         this._availableForBuy = param2;
      }
      
      override public function resolveProps(param1:Object = null) : StateProperties
      {
         if(param1 != null)
         {
            if(param1[ROOT_INVENTORY_INFO_FIELD] && param1[PARENT_UNLOCKED_INFO_FIELD])
            {
               return this._availableForBuy;
            }
            if(param1[RESEARCH_GRAPH])
            {
               return this._availableForBuy;
            }
         }
         return super.resolveProps(param1);
      }
   }
}
