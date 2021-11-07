package net.wg.gui.popover.data
{
   public class AcousticTypeBlockData
   {
       
      
      public var bgImgPosY:Number = -1;
      
      public var items:Vector.<AcousticItemData> = null;
      
      public function AcousticTypeBlockData(param1:Number, param2:Vector.<AcousticItemData>)
      {
         super();
         this.bgImgPosY = param1;
         this.items = param2;
      }
   }
}
