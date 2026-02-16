# Serviço para conectar ao Firestore
require "google/cloud/firestore"

class FirestoreService
  def initialize
    # Caminho do arquivo da Service Account
    keyfile = Rails.root.join("firebase-key.json")
    @firestore = Google::Cloud::Firestore.new(
      project_id: ENV["FIREBASE_PROJECT_ID"],
      credentials: keyfile
    )
  end

  def get_collection(collection_name)
    @firestore.col(collection_name).get
  end

  def add_document(collection_name, data)
    @firestore.col(collection_name).add(data)
  end

  def get_document(collection_name, doc_id)
    @firestore.col(collection_name).doc(doc_id).get
  end

  def update_document(collection_name, doc_id, data)
    @firestore.col(collection_name).doc(doc_id).set(data, merge: true)
  end

  def delete_document(collection_name, doc_id)
    @firestore.col(collection_name).doc(doc_id).delete
  end
end
