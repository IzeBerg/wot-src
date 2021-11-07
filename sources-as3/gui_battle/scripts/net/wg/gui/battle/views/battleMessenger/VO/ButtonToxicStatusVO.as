package net.wg.gui.battle.views.battleMessenger.VO
{
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ButtonToxicStatusVO
   {
       
      
      public var status:int = -1;
      
      public var tooltip:String = null;
      
      public var squadNum:int = -1;
      
      public var enabled:Boolean = true;
      
      public function ButtonToxicStatusVO()
      {
         super();
      }
      
      public function parseData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.status = param1.status;
         var _loc2_:String = param1.tooltip;
         this.tooltip = !!StringUtils.isEmpty(_loc2_) ? null : _loc2_;
         this.squadNum = param1.squadNum;
         this.enabled = param1.enabled;
      }
      
      public function reset() : void
      {
         this.status = -1;
         this.tooltip = null;
         this.squadNum = -1;
         this.enabled = true;
      }
   }
}
