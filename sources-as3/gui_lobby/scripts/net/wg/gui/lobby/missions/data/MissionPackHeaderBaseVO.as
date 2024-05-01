package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionPackHeaderBaseVO extends DAAPIDataClass
   {
      
      private static const TITLE_BLOCK_FIELD_NAME:String = "titleBlock";
      
      private static const DESC_BLOCK_FIELD_NAME:String = "descBlock";
       
      
      private var _titleBlockVO:HeaderTitleBlockBaseVO;
      
      private var _descBlockVO:HeaderDescBlockVO;
      
      public function MissionPackHeaderBaseVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TITLE_BLOCK_FIELD_NAME)
         {
            this._titleBlockVO = new this.titleBlockClass(param2);
            return false;
         }
         if(param1 == DESC_BLOCK_FIELD_NAME)
         {
            this._descBlockVO = new this.descBlockClass(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._titleBlockVO.dispose();
         this._titleBlockVO = null;
         if(this._descBlockVO)
         {
            this._descBlockVO.dispose();
            this._descBlockVO = null;
         }
         super.onDispose();
      }
      
      public function get descBlockClass() : Class
      {
         return HeaderDescBlockVO;
      }
      
      public function get titleBlockClass() : Class
      {
         return HeaderTitleBlockBaseVO;
      }
      
      public function get titleBlockVO() : HeaderTitleBlockBaseVO
      {
         return this._titleBlockVO;
      }
      
      public function get descBlockVO() : HeaderDescBlockVO
      {
         return this._descBlockVO;
      }
   }
}
