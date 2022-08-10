package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SmallSlotVO extends DAAPIDataClass
   {
       
      
      public var itemIcon:String = "";
      
      public var itemIsWide:Boolean = false;
      
      public var isBgVisible:Boolean = true;
      
      public var isFrameVisible:Boolean = true;
      
      public var iconWidth:int = -1;
      
      public var iconHeight:int = -1;
      
      public function SmallSlotVO(param1:Object)
      {
         super(param1);
      }
   }
}
