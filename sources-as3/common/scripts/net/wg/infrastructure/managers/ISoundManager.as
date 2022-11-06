package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.base.meta.ISoundManagerMeta;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   
   public interface ISoundManager extends ISoundManagerMeta
   {
       
      
      function playControlsSnd(param1:String, param2:String, param3:String) : void;
      
      function addSoundsHdlrs(param1:ISoundable) : void;
      
      function removeSoundHdlrs(param1:ISoundable) : void;
   }
}
