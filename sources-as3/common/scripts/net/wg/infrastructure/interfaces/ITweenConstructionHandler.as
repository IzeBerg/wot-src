package net.wg.infrastructure.interfaces
{
   public interface ITweenConstructionHandler
   {
       
      
      function constructionOnStart(param1:ISimpleTweenPropertiesVO) : void;
      
      function constructionOnComplete(param1:ISimpleTweenPropertiesVO) : void;
      
      function onComplete(param1:ISimpleTweenPropertiesVO) : void;
      
      function onStart(param1:ISimpleTweenPropertiesVO) : void;
   }
}
