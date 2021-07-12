package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.rally.interfaces.IRallyListItemVO;
   import net.wg.gui.rally.vo.RallyCandidateVO;
   import net.wg.gui.rally.vo.RallyVO;
   
   public class CSCommandVO extends DAAPIDataClass implements IRallyListItemVO
   {
      
      private static const CREATOR_FIELD:String = "creator";
       
      
      public var creator:RallyCandidateVO = null;
      
      public var creatorName:String = "";
      
      public var cfdUnitID:Number = 0;
      
      public var unitMgrID:Number = 0;
      
      public var inBattle:Boolean = false;
      
      public var commandSize:Number = 7;
      
      public var playersCount:Number = 0;
      
      public var rating:String = "";
      
      public var isFreezed:Boolean = false;
      
      public var isRestricted:Boolean = false;
      
      public var server:String = "";
      
      public var description:String = "";
      
      public var unit:RallyVO = null;
      
      private var _peripheryID:Number = 0;
      
      public function CSCommandVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Boolean = true;
         if(param1 == CREATOR_FIELD)
         {
            this.creator = new RallyCandidateVO(param2);
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      override protected function onDispose() : void
      {
         this.creator.dispose();
         this.creator = null;
         this.unit.dispose();
         this.unit = null;
         this.creatorName = null;
         this.rating = null;
         this.server = null;
         this.description = null;
         super.onDispose();
      }
      
      public function get peripheryID() : Number
      {
         return this._peripheryID;
      }
      
      public function set peripheryID(param1:Number) : void
      {
         this._peripheryID = param1;
      }
      
      public function get mgrID() : Number
      {
         return this.unitMgrID;
      }
      
      public function get rallyIndex() : Number
      {
         return this.cfdUnitID;
      }
   }
}
