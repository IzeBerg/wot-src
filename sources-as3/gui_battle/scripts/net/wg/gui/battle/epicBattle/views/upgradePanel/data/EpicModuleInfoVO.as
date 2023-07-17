package net.wg.gui.battle.epicBattle.views.upgradePanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicModuleInfoVO extends DAAPIDataClass
   {
      
      private static const MODULE_LABEL:String = "module";
       
      
      public var header:String = "";
      
      public var description:String = "";
      
      public var category:String = "";
      
      public var hotKeys:Array = null;
      
      public var hotKeysVKeys:Array = null;
      
      public var module:EpicConfiguratorModuleVO = null;
      
      public function EpicModuleInfoVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == MODULE_LABEL)
         {
            if(this.module)
            {
               this.module.dispose();
            }
            this.module = new EpicConfiguratorModuleVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.hotKeys)
         {
            this.hotKeys.splice(0,this.hotKeys.length);
            this.hotKeys = null;
         }
         if(this.hotKeysVKeys)
         {
            this.hotKeysVKeys.splice(0,this.hotKeysVKeys.length);
            this.hotKeysVKeys = null;
         }
         this.module.dispose();
         this.module = null;
         super.onDispose();
      }
   }
}
