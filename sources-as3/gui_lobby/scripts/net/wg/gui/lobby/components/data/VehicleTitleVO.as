package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleTitleVO extends DAAPIDataClass
   {
      
      private static const ABILITY:String = "ability";
       
      
      public var tankTierStr:String = "";
      
      public var tankNameStr:String = "";
      
      public var tankTierStrSmall:String = "";
      
      public var tankNameStrSmall:String = "";
      
      public var typeIconPath:String = "";
      
      public var isElite:Boolean = false;
      
      public var statusStr:String = "";
      
      public var intCD:uint = 0;
      
      public var roleText:String = "";
      
      public var showInfoIcon:Boolean = true;
      
      private var _ability:AbilityBlockVO = null;
      
      public function VehicleTitleVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ABILITY)
         {
            this._ability = Boolean(param2) ? new AbilityBlockVO(param2) : null;
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._ability)
         {
            this._ability.dispose();
            this._ability = null;
         }
         super.onDispose();
      }
      
      public function get ability() : AbilityBlockVO
      {
         return this._ability;
      }
   }
}
