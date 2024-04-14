package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionConditionsContainerVO extends DAAPIDataClass
   {
       
      
      public var linkage:String = "";
      
      public var linkageBig:String = "";
      
      public var rendererLinkage:String = "";
      
      public var data:Object = null;
      
      public var isDetailed:Boolean = false;
      
      public function MissionConditionsContainerVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this.data);
         this.data = null;
         super.onDispose();
      }
   }
}
