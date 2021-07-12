package net.wg.gui.lobby.vehicleCustomization.data.customizationPanel
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationCarouselFilterVO extends DAAPIDataClass
   {
      
      private static const GROUPS_FIELD:String = "groups";
       
      
      public var purchasedEnabled:Boolean = false;
      
      public var historicEnabled:Boolean = false;
      
      public var nonHistoricEnabled:Boolean = false;
      
      public var appliedEnabled:Boolean = false;
      
      public var hideOnAnotherVehEnabled:Boolean = false;
      
      public var showOnlyProgressionDecalsEnabled:Boolean = false;
      
      public var showOnlyEditableStylesEnabled:Boolean = false;
      
      public var showOnlyNonEditableStylesEnabled:Boolean = false;
      
      public var selectedGroup:int = -1;
      
      public var groupCount:int = -1;
      
      public var groups:Vector.<String> = null;
      
      public var formfactorGroups:Array = null;
      
      public function CustomizationCarouselFilterVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         if(GROUPS_FIELD == param1)
         {
            App.utils.asserter.assert(param2 is Array,"Field \'groups\' is expected to be array");
            _loc3_ = param2 as Array;
            this.groups = new Vector.<String>(0);
            for each(_loc4_ in _loc3_)
            {
               this.groups.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.groups)
         {
            this.groups.splice(0,this.groups.length);
            this.groups = null;
         }
         if(this.formfactorGroups)
         {
            this.formfactorGroups.splice(0,this.formfactorGroups.length);
            this.formfactorGroups = null;
         }
         super.onDispose();
      }
   }
}
