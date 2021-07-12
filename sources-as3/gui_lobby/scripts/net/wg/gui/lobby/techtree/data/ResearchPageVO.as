package net.wg.gui.lobby.techtree.data
{
   import net.wg.gui.data.BenefitsDataVO;
   
   public class ResearchPageVO extends BenefitsDataVO
   {
       
      
      public var backBtnLabel:String = "";
      
      public var backBtnDescrLabel:String = "";
      
      public var isPremiumLayout:Boolean = false;
      
      public function ResearchPageVO(param1:Object)
      {
         super(param1);
      }
   }
}
