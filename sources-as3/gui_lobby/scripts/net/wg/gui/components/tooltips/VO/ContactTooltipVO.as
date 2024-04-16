package net.wg.gui.components.tooltips.VO
{
   import net.wg.gui.messenger.data.ContactItemVO;
   
   public class ContactTooltipVO extends ContactItemVO
   {
       
      
      public var statusDescription:String = "";
      
      public var units:Array;
      
      public function ContactTooltipVO(param1:Object)
      {
         super(param1);
      }
   }
}
