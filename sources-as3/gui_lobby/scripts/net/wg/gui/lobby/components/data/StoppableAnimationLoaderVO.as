package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StoppableAnimationLoaderVO extends DAAPIDataClass
   {
       
      
      public var image:String = "";
      
      public var animationPath:String = "";
      
      public var animationLinkage:String = "";
      
      public function StoppableAnimationLoaderVO(param1:Object)
      {
         super(param1);
      }
   }
}
