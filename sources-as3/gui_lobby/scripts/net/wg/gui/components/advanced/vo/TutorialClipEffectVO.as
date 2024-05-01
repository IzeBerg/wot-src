package net.wg.gui.components.advanced.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TutorialClipEffectVO extends DAAPIDataClass
   {
       
      
      public var linkage:String = "";
      
      public var offsetX:int = -1;
      
      public var offsetY:int = -1;
      
      public function TutorialClipEffectVO(param1:Object)
      {
         super(param1);
      }
   }
}
