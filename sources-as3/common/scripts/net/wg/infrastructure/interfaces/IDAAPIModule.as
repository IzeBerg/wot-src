package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.base.meta.IBaseDAAPIModuleMeta;
   import net.wg.infrastructure.interfaces.entity.IDAAPIEntity;
   
   public interface IDAAPIModule extends IBaseDAAPIModuleMeta, IDAAPIEntity
   {
       
      
      function get disposed() : Boolean;
      
      function get isDAAPIInited() : Boolean;
   }
}
