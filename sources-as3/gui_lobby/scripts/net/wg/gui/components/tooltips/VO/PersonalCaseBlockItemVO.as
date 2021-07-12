package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PersonalCaseBlockItemVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var value:String = "";
      
      public var premiumValue:String = "";
      
      public var extra:String = "";
      
      public var imageType:String = "";
      
      public var image:String = "";
      
      public function PersonalCaseBlockItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.name = null;
         this.value = null;
         this.premiumValue = null;
         this.extra = null;
         this.imageType = null;
         this.image = null;
         super.onDispose();
      }
   }
}
