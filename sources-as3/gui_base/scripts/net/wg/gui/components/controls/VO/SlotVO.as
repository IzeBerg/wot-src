package net.wg.gui.components.controls.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SlotVO extends DAAPIDataClass
   {
       
      
      public var id:String = "";
      
      public var icon:String = "";
      
      public var type:int = -1;
      
      public var isDischarging:Boolean = true;
      
      public var inCooldown:Boolean = false;
      
      public var cooldownPercent:Number = 0.0;
      
      public var leftTime:Number = -1;
      
      public var isInactive:Boolean = false;
      
      public var isPermanent:Boolean = false;
      
      public var group:int = -1;
      
      public function SlotVO(param1:Object)
      {
         super(param1);
      }
   }
}
