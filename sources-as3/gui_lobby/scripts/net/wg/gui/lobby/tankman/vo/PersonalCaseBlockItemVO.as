package net.wg.gui.lobby.tankman.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PersonalCaseBlockItemVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var value:String = "";
      
      public var secondValue:String = "";
      
      public var imageType:String = "";
      
      public var image:String = "";
      
      public var isValueActive:Boolean = false;
      
      public var isSecondValueActive:Boolean = false;
      
      public var isLabelActive:Boolean = true;
      
      public function PersonalCaseBlockItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.name = null;
         this.value = null;
         this.secondValue = null;
         this.imageType = null;
         this.image = null;
         super.onDispose();
      }
   }
}
