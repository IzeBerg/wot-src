package net.wg.data.managers.impl
{
   import net.wg.infrastructure.base.meta.IPythonTweenMeta;
   import net.wg.infrastructure.base.meta.impl.PythonTweenMeta;
   import net.wg.infrastructure.interfaces.ITween;
   import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
   
   public class PythonTween extends PythonTweenMeta implements ITween, IPythonTweenMeta
   {
       
      
      public function PythonTween(param1:ITweenPropertiesVO)
      {
         super();
         props = param1;
      }
   }
}
